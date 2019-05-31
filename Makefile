.PHONY: help client server

HELP_FUNC = \
    %help; \
    while(<>) { \
        if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target]\n"; \
    for ( sort keys %help ) { \
        print "$$_\n"; \
        printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

help:
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)

server: ## Deploy the Server
	cd server && \
		npm run build
	cd infrastructure && \
		terraform init && \
		cp ../.env ./terraform.tfvars && \
		terraform apply -auto-approve && \
		rm ./terraform.tfvars

client: ## Deploy the Client
	cd client && \
		npm run build && \
		aws s3 sync build s3://diet.kye.dev && \
		aws s3 cp build/index.html s3://diet.kye.dev/index.html --cache-control max-age=0

all: server client ## Deploy everything