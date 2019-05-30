deploy-server:
	pushd src/server && \
		npm run build
	pushd infrastructure && \
		terraform init && \
		cp ../.env ./terraform.tfvars && \
		terraform apply -auto-approve && \
		rm ./terraform.tfvars