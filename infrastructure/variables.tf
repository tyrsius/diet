variable "region" {
  default = "us-west-2"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
  version = "~> 2.11.0"
}

terraform {
  backend "s3" {
    bucket               = "tyrsius-terraform-state"
    key                  = "diet"
    workspace_key_prefix = "diet"
    region               = "us-west-2"
  }
}

locals {
  app_namespace     = "diet"
  api_lambda_file   = "../build/server.zip"
  api_lamba_name    = "${local.app_namespace}-api"
  site_domain            = "diet.kye.dev"
  api_domain            = "diet-api.kye.dev"
  cloufront_domains = ["${local.site_domain}"]
  api_stage         = "prod"
  api_gateway_name  = "${local.app_namespace}-api"
  default_tags = {
    Namespace = "${local.app_namespace}"
  }
}

variable "AIRTABLE_KEY" {}
variable "AIRTABLE_DIET_BASE_ID" {}
