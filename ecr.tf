resource "aws_ecr_repository" "nginx" {
  name                 = "nginx"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "nginx"
    Project = var.product
    Owner   = "Terraform"
  }
}

resource "aws_ecr_repository" "php-fpm" {
  name                 = "php-fpm"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "php-fpm"
    Project = var.product
    Owner   = "Terraform"
  }
}
