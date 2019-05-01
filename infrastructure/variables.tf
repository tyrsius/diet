variable "region" {
  default = "us-west-2"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
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
  domain            = "diet.kye.dev"
  cloufront_domains = ["${local.domain}"]
  api_stage         = "${terraform.workspace}"
  api_gateway_name  = "${local.app_namespace}-api"
  default_tags = {
    Namespace = "${local.app_namespace}"
  }
}

variable "AIRTABLE_KEY" {}
variable "AIRTABLE_DIET_BASE_ID" {}
