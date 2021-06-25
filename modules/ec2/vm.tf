resource "aws_key_pair" "api" {
  key_name   = "${var.product}-${var.environment}"
  public_key = var.public_key
}

resource "aws_instance" "api" {
  count                       = length(var.azs)
  ami                         = data.aws_ami.ubuntu.id
  availability_zone           = element(var.azs, count.index)
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${aws_security_group.api.id}", "${aws_security_group.lb.id}"]
  subnet_id                   = sort(data.aws_subnet_ids.public.ids)[count.index]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.api.id

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name        = "api-${var.product}-${var.environment}-${count.index}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
