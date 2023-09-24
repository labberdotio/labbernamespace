#!/bin/bash
set -e

# set -x

# Set the k8s API
export KUBECLUSTER="nuke-k3s"
export KUBECONFIG="/Users/john/.kube/config.${KUBECLUSTER}"

# Final domain name of GFS SAAS deployment, 
# i.e. gfs.${HELM_DOMAIN}
export HELM_DOMAIN="labber.io"

# Helm values file in gfssaas folder
export HELM_VALUES="values.yaml"

# k8s
export HELM_CLUSTER="${KUBECLUSTER}" # "nuke-k3s"
export HELM_CONTEXT="${KUBECLUSTER}" # "nuke-k3s"
export HELM_NAS_NFS_HOST="10.88.88.230" # "10.99.99.201"
export HELM_NAS_NFS_PATH="/mnt/zall/k3s/nfs/${KUBECLUSTER}" # /mnt/zpool/botcanics/nfs/k3s
export HELM_KUBECONFIG="/home/john/.kube/config.${KUBECLUSTER}"
export HELM_RELEASE="labber"
export HELM_NAMESPACE="labber"
# export HELM_DEBUG="--debug"
export HELM_DEBUG=""
export THISDOMAIN="${HELM_DOMAIN}"
export THISHOST="${HELM_RELEASE}.${THISDOMAIN}"
