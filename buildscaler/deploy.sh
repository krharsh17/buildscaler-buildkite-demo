#!/bin/sh

set -e

kubectl --namespace buildkite get secret buildkite-agent || {
    echo "secret/buildkite-agent not found in namespace buildkite"
    echo "To create it: kubectl --namespace=buildkite create secret generic buildkite-agent --from-literal=token=<Buildkite Agent Token>"
    exit 1
}

kubectl --namespace kube-system apply -f rbac-kube-system.yaml

kubectl_apply() {
    kubectl --namespace buildkite apply -f "$*"
}

kubectl_apply rbac.yaml
kubectl_apply service.yaml
kubectl_apply buildkite-deployment.yaml
kubectl_apply apiservice.yaml
