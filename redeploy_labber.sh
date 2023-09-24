#!/bin/bash

set -x

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo "This Dir: $THIS_DIR"
source $THIS_DIR/settings.sh

# 
# eval $(aws ecr get-login --no-include-email --profile=ecr-user --region=us-west-2)
# 
# kubectl create namespace ${HELM_NAMESPACE} || true
# 
# kubectl delete secret regcred --namespace=${HELM_NAMESPACE} || true
# kubectl create secret generic regcred --from-file=.dockerconfigjson=/home/bots/.docker/config.json --type=kubernetes.io/dockerconfigjson --namespace=${HELM_NAMESPACE}
# 

# kubectl create namespace ${HELM_NAMESPACE} || true

# NFS PVEs
# helm repo add nfs-subdir-external-provisioner \
# https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner || true

# 
# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/pull/166/files
# 
# helm uninstall ${HELM_RELEASE}-nfs-provisioner \
# --namespace ${HELM_NAMESPACE} || true

# 
# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/pull/166/files
# 
# helm install ${HELM_RELEASE}-nfs-provisioner \
# nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
# --namespace ${HELM_NAMESPACE} \
# --create-namespace \
# --set nfs.server=${HELM_NAS_NFS_HOST} \
# --set nfs.path=${HELM_NAS_NFS_PATH} \
# --set storageClass.name=${HELM_RELEASE}-nfs-client \
# --set storageClass.provisionerName=k8s-sigs.io/${HELM_RELEASE}-nfs-provisioner \
# --set storageClass.onDelete=retain \
# --set storageClass.pathPattern='${.PVC.namespace}-${.PVC.name}' || true

# cp ${THIS_DIR}/labber/${HELM_VALUES} ${THIS_DIR}/labber/values.yaml

helm upgrade \
  --namespace ${HELM_NAMESPACE} ${HELM_DEBUG} \
  --values "${THIS_DIR}/labber/${HELM_VALUES}" \
  --set global.domain.name="${HELM_DOMAIN}" \
  ${HELM_RELEASE} labber
