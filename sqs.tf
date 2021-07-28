resource "aws_sqs_queue" "dlq" {
  name = "dlq-${var.product}-${var.environment}"

  tags = {
    Name        = "dlq-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "main" {
  name                      = "main-${var.product}-${var.environment}"
  receive_wait_time_seconds = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 4
  })

  tags = {
    Name        = "main-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
