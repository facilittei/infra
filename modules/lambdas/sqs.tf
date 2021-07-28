resource "aws_sqs_queue" "dlq" {
  name = "dlq-${var.lambda_name}-${var.product}-${var.environment}"

  tags = {
    Name        = "dlq-${var.lambda_name}-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "main" {
  name                      = "main-${var.lambda_name}-${var.product}-${var.environment}"
  receive_wait_time_seconds = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })

  tags = {
    Name        = "main-${var.lambda_name}-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
