resource "aws_lambda_function" "lambda" {
  function_name = "${var.lambda_name}-${var.product}-${var.environment}"
  s3_bucket     = "${var.lambda_name}-${var.product}-${var.environment}"
  s3_key        = "main.zip"
  handler       = "main"
  runtime       = "go1.x"
  role          = aws_iam_role.lambda.arn

  environment {
    variables = {
      name = "${var.lambda_name}-${var.product}-${var.environment}"
    }
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  function_name    = aws_lambda_function.lambda.arn
  event_source_arn = aws_sqs_queue.main.arn
  enabled          = true
  batch_size       = 1
}
