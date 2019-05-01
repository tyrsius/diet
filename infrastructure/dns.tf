data "aws_route53_zone" "kye_dev" {
  name = "kye.dev."
}

provider "aws" {
  region = "us-east-1"
  alias  = "certs"
}

module "cert" {
  source = "github.com/azavea/terraform-aws-acm-certificate?ref=1.0.0"

  providers = {
    aws.acm_account     = "aws.certs"
    aws.route53_account = "aws"
  }

  domain_name           = "${local.domain}"
  hosted_zone_id        = "${data.aws_route53_zone.kye_dev.zone_id}"
  validation_record_ttl = "60"
}

resource "aws_route53_record" "site" {
  name    = "${local.domain}"
  zone_id = "${data.aws_route53_zone.kye_dev.zone_id}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.site.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.site.hosted_zone_id}"
    evaluate_target_health = false
  }
}
