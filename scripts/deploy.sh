#!/bin/bash

# npm run build

pushd infrastructure
terraform init
cp ../.env ./terraform.tfvars
terraform apply
rm ./terraform.tfvars
popd

# aws s3 sync src s3://lesswrong.kye.dev 
# aws s3 cp src/index.html s3://lesswrong.kye.dev/index.html --cache-control max-age=0