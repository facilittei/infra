data "aws_vpc" "main" {
  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
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

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name = "tag:Name"
    values = [
      "private-${var.product}-${var.environment}-0",
      "private-${var.product}-${var.environment}-1"
    ]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_acm_certificate" "api" {
  domain      = var.certificate_domain_api
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_route_table" "private" {
  filter {
    name   = "tag:Name"
    values = ["private-${var.product}-${var.environment}"]
  }
}
