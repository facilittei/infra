output "lambda_url" {
  description = "The lambda bucket domain name URL."
  value       = aws_s3_bucket.lambda.bucket_domain_name
}
