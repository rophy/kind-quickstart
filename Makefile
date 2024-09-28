install-cli:	## Install k8s commin CLI in your machin.
	@scripts/install-cli.sh

kind:			## Create a kind cluster
	@scripts/create-kind.sh


clean:			## Remove kind cluster
	@scripts/remove-kind.sh

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:			## This help command.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
