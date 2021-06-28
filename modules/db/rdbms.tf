resource "aws_db_subnet_group" "main" {
  name       = "${var.product}-${var.environment}"
  subnet_ids = data.aws_subnet_ids.public.ids

  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_db_instance" "main" {
  identifier           = "main-${var.product}-${var.environment}"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instance_type
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  allocated_storage    = 20
  skip_final_snapshot  = true
  storage_encrypted    = false
  multi_az             = false

  vpc_security_group_ids = data.aws_security_groups.public.ids
  db_subnet_group_name   = aws_db_subnet_group.main.id

  tags = {
    Name        = "main-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
