
#!/bin/bash

set -e
set -u

# https://stackoverflow.com/a/687052
tmpdir="$(mktemp -d)"
trap 'rm -rf -- "$tmpdir"' EXIT

pushd $tmpdir

# kubectl
which kubectl && exists=1 || exists=0
if [ "$exists" == "0" ]; then
    version=1.28.11 \
    && wget https://dl.k8s.io/release/v${version}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && sudo mv ./kubectl /usr/local/bin/
fi

# kind
which kind && exists=1 || exists=0
if [ "$exists" == "0" ]; then
    version=0.17.0 \
    && wget https://kind.sigs.k8s.io/dl/v${version}/kind-linux-amd64 \
    && chmod +x ./kind-linux-amd64 \
    && sudo mv ./kind-linux-amd64 /usr/local/bin/kind
fi

# helm
which helm && exists=1 || exists=0
if [ "$exists" == "0" ]; then
    version=3.13.3 \
    && wget https://get.helm.sh/helm-v${version}-linux-amd64.tar.gz \
    && tar -zxf helm-v${version}-linux-amd64.tar.gz \
    && sudo mv ./linux-amd64/helm /usr/local/bin/helm 
fi
