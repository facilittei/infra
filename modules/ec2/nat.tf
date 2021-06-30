resource "aws_key_pair" "nat" {
  key_name   = "nat-${var.product}-${var.environment}"
  public_key = var.public_key
}

resource "aws_instance" "nat" {
  ami                         = var.nat_instance
  availability_zone           = var.azs[0]
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${aws_security_group.nat.id}"]
  subnet_id                   = sort(data.aws_subnet_ids.public.ids)[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.nat.id
  source_dest_check           = false

  tags = {
    Name        = "nat-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_route" "private" {
  route_table_id         = data.aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = aws_instance.nat.id

  depends_on = [
    aws_instance.nat
  ]
}
