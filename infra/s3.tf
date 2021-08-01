resource "aws_s3_bucket" "static_host" {
  bucket = local.s3_bucket_name

  versioning {
    enabled = false
  }

  policy = data.aws_iam_policy_document.s3_cloudfront_policy.json
}

resource "aws_s3_bucket_public_access_block" "static_host" {
  bucket                  = aws_s3_bucket.static_host.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}