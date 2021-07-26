resource "aws_s3_bucket" "lambda" {
  bucket = "${var.lambda_name}-${var.product}-${var.environment}"
  acl    = "private"

  tags = {
    Name        = "${var.lambda_name}-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
