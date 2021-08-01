data "aws_iam_policy_document" "s3_cloudfront_policy" {
  statement {
    sid       = "CloudFront"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cloud_front_01.iam_arn]
    }
  }
}