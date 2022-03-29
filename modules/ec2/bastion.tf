resource "aws_instance" "bastion" {
  ami                         = "ami-0dd76f917833aac4b" // data.aws_ami.ubuntu.id
  availability_zone           = var.azs[0]
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = sort(data.aws_subnet_ids.public.ids)[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.api.id

  tags = {
    Name        = "bastion-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
