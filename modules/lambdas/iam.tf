resource "aws_iam_role" "lambda" {
  name               = "${var.lambda_name}-${var.product}-${var.environment}"
  assume_role_policy = file("${path.module}/policies/lambda.json")

  tags = {
    Name        = "lambda-${var.lambda_name}-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "sqs" {
  name   = "sqs-${var.lambda_name}-${var.product}-${var.environment}"
  policy = file("${path.module}/policies/sqs.json")

  tags = {
    Name        = "sqs-${var.lambda_name}-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "logs" {
  name   = "logs-${var.lambda_name}-${var.product}-${var.environment}"
  policy = file("${path.module}/policies/cloudwatch.json")

  tags = {
    Name        = "logs-${var.lambda_name}-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "lambda-sqs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.sqs.arn
}

resource "aws_iam_role_policy_attachment" "lambda-logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.logs.arn
}
