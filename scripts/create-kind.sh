#!/bin/bash

set -e # exits on non-zero RC
set -u # exits on undefined vars

# https://stackoverflow.com/a/687052
tmpdir="$(mktemp -d)"
trap 'rm -rf -- "$tmpdir"' EXIT

# https://stackoverflow.com/a/246128
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cluster_name=$(kind get clusters | head -n 1)
if [ "$cluster_name" == "kind" ]; then
    read -p "kind cluster already exists, delete it and start over [y]?" answer
    answer=${answer:-y}
    if [ "$answer" == "y" ]; then
        $script_dir/remove-kind.sh
    else
        exit 1
    fi
fi

kind create cluster --image=kindest/node:v1.24.17

# metrics-server
kubectl apply -f components/metrics-server/
