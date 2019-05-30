server-deploy:
	cd server && \
		npm run build
	cd infrastructure && \
		terraform init && \
		cp ../.env ./terraform.tfvars && \
		terraform apply -auto-approve && \
		rm ./terraform.tfvars

client-deploy:
	cd client && \
		npm run build && \
		aws s3 sync build s3://diet.kye.dev && \
		aws s3 cp build/index.html s3://diet.kye.dev/index.html --cache-control max-age=0