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
