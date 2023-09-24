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

echo " DELETING HELM PACKAGE: ${HELM_RELEASE} in K8S namespace: ${HELM_NAMESPACE}"

kubectl create namespace ${HELM_NAMESPACE} || true

# helm list --namespace ${HELM_NAMESPACE}

helm delete \
  --namespace ${HELM_NAMESPACE} ${HELM_DEBUG} \
  ${HELM_RELEASE} || true

helm uninstall \
  ${HELM_RELEASE}-nfs-provisioner \
--namespace ${HELM_NAMESPACE} || true

# kubectl delete secret regcred --namespace=${HELM_NAMESPACE} || true
