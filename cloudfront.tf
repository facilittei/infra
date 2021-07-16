data "aws_acm_certificate" "assets" {
  domain      = var.certificate_domain_assets
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_origin_access_identity" "assets" {
  comment = "assets-${var.product}-${var.environment}"
}

resource "aws_cloudfront_origin_access_identity" "videos" {
  comment = "videos-${var.product}-${var.environment}"
}

resource "aws_cloudfront_distribution" "assets" {
  origin {
    domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.assets.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.assets.cloudfront_access_identity_path
    }
  }

  enabled = true
  aliases = [var.certificate_domain_assets]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.assets.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.assets.arn
    cloudfront_default_certificate = false
    ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "assets-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_cloudfront_distribution" "videos" {
  origin {
    domain_name = aws_s3_bucket.videos.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.videos.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.videos.cloudfront_access_identity_path
    }
  }

  enabled = true
  aliases = [var.certificate_domain_videos]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.videos.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.assets.arn
    cloudfront_default_certificate = false
    ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "videos-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
