resource "aws_instance" "observability" {
  ami                         = "ami-04505e74c0741db8d"
  availability_zone           = var.azs[0]
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.observability.id}"]
  subnet_id                   = sort(data.aws_subnet_ids.public.ids)[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.api.id

  tags = {
    Name        = "observability-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
