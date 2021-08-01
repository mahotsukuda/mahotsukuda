resource "aws_acm_certificate" "acm_01" {
  provider          = aws.east
  domain_name       = local.routing_domain
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "acm_01_validation" {
  provider                = aws.east
  certificate_arn         = aws_acm_certificate.acm_01.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_01_certificate_record : record.fqdn]
}