#!/usr/bin/env bash
set -e

# Set the k8s API
export KUBECLUSTER="awslab-k3s"
export KUBECONFIG="${HOME}/.kube/config.${KUBECLUSTER}"

export DOCKER_REGISTRY="513562861795.dkr.ecr.us-west-2.amazonaws.com"

# Final domain name of GFS SAAS deployment, 
# i.e. gfs.${HELM_DOMAIN}
export HELM_DOMAIN="labber.io"

# Helm values file in gfssaas folder
export HELM_VALUES="values.awslab.yaml"

# k8s
export HELM_CLUSTER="${KUBECLUSTER}"
export HELM_CONTEXT="${KUBECLUSTER}"
# export HELM_NAS_NFS_HOST=
# export HELM_NAS_NFS_PATH=
# export HELM_NAS_NFS_PATH=
export HELM_KUBECONFIG="/home/john/.kube/config.${KUBECLUSTER}"
export HELM_RELEASE="labber"
export HELM_NAMESPACE="labber"
export HELM_DEBUG=""
export THISDOMAIN="${HELM_DOMAIN}"
export THISHOST="${HELM_RELEASE}.${THISDOMAIN}"

