variable "region" {
  default = "us-west-2"
}

variable api_lambda_file {
  default = "../build/server.zip"
}

variable app_namespace {}
variable site_domain {}
variable api_domain {}