
provider "aws" {
  region  = var.region
  version = "~> 2.11.0"
}

data "aws_caller_identity" "current" {}

terraform {
  backend "s3" {}
  required_version = ">= 0.12"
}

locals {
  api_lamba_name    = "${var.app_namespace}-api"
  api_gateway_name  = "${var.app_namespace}-api"
  hosted_zone_name  = join(".", slice(split(".", var.site_domain), 1, length(split(".", var.site_domain)) - 1))
  site_domain       = var.site_domain
  api_domain        = "api-${var.site_domain}"
  cloufront_domains = [local.site_domain]
  default_tags = {
    Namespace = var.app_namespace
  }
}
