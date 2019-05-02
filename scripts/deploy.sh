#!/bin/bash


pushd src/server
npm run build
popd

pushd infrastructure
terraform init
cp ../.env ./terraform.tfvars
terraform apply -auto-approve 
rm ./terraform.tfvars
popd

# aws s3 sync src s3://lesswrong.kye.dev 
# aws s3 cp src/index.html s3://lesswrong.kye.dev/index.html --cache-control max-age=0