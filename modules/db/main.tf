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

data "aws_security_groups" "public" {
  filter {
    name = "tag:Name"
    values = [
      "api-${var.product}-${var.environment}"
    ]
  }
}
