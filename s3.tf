resource "aws_s3_bucket" "assets" {
  bucket = "${var.product}-${var.environment}"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
    allowed_origins = var.cors_allowed_url
    max_age_seconds = 3000
    expose_headers = [
      "Set-Cookie",
      "Access-Control-Allow-Origin",
      "Access-Control-Allow-Credentials",
    ]
  }
}
