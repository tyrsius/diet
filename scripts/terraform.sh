#!/usr/bin/env bash

_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${_dir}/common.sh"

# DEPENDS ON THE FOLLOWING ENVIRONMENT VARIABLES BEING SET BY CI
: "${terraform_state_bucket?Unset variable}"

function terraform_preinit() {
  terraform init \
    -backend-config="bucket=${terraform_state_bucket}" \
    -backend-config="region=${TF_VAR_region:-us-west-2}" \
    -backend-config="key=sprockets_berlioux_oauth" \
    -backend-config="encrypt=true"
}

function terraform_init() {
  terraform_preinit
  # If the workspace doesn not exist, create it.
  if ! terraform workspace select ${1}; then
      terraform workspace new ${1}
  fi
  terraform_preinit
}

function terraform_apply () {
  terraform apply -auto-approve
}

function terraform_plan () {
  terraform plan
}