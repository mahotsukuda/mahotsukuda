resource "aws_cloudfront_origin_access_identity" "cloud_front_01" {
  comment = var.s3_bucket_name
}

resource "aws_cloudfront_distribution" "cloud_front_01" {
  aliases             = [var.routing_domain]
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = var.s3_bucket_name
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = aws_s3_bucket.static_host.bucket_regional_domain_name
    origin_id   = var.s3_bucket_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloud_front_01.cloudfront_access_identity_path
    }
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.acm_01.arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method       = "sni-only"
  }
}