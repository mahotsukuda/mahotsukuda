data "aws_route53_zone" "origin_domain" {
  name = var.domain
}

resource "aws_route53_record" "domain_01" {
  name    = var.routing_domain
  type    = "A"
  zone_id = data.aws_route53_zone.origin_domain.zone_id

  alias {
    name                   = aws_cloudfront_distribution.cloud_front_01.domain_name
    zone_id                = aws_cloudfront_distribution.cloud_front_01.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "domain_01_certificate_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_01.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 700
  type            = each.value.type
  zone_id         = data.aws_route53_zone.origin_domain.zone_id
}