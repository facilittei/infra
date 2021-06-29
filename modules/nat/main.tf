data "aws_vpc" "main" {
  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

data "aws_route_table" "private" {
  filter {
    name   = "tag:Name"
    values = ["private-${var.product}-${var.environment}"]
  }
}

data "aws_security_group" "nat" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:Name"
    values = ["nat-${var.product}-${var.environment}"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name = "tag:Name"
    values = [
      "public-${var.product}-${var.environment}-0",
      "public-${var.product}-${var.environment}-1"
    ]
  }
}

resource "aws_key_pair" "nat" {
  key_name   = "nat-${var.product}-${var.environment}"
  public_key = var.public_key
}

resource "aws_instance" "nat" {
  ami                         = var.nat_instance
  availability_zone           = var.azs[0]
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${data.aws_security_group.nat.id}"]
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
}
