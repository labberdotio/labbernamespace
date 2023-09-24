#!/bin/bash

# set -x

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo "This Dir: $THIS_DIR"
source $THIS_DIR/settings.sh

# export GFSNAMESPACE="buildkite"
# export GFSNAMESPACE="snagger"

export GFSNAMESPACE="${1}"
if [ -z "${GFSNAMESPACE}" ]; then
  echo "Error: No namespace given"
  echo "Usage: ./undeploy_labbernamespace.sh NAMESPACE"
  exit 0
fi

echo "Undeploying services for namespace: ${GFSNAMESPACE}"

export HELM_NAMESPACE_NAMESPACE="${HELM_NAMESPACE}"
export HELM_NAMESPACE_RELEASE="${GFSNAMESPACE}-${HELM_RELEASE}"
# export HELM_NAMESPACE_DOMAIN="${GFSNAMESPACE}.${HELM_DOMAIN}"
export HELM_NAMESPACE_DOMAIN="${HELM_DOMAIN}"

# kubectl create namespace ${HELM_NAMESPACE_NAMESPACE} || true

helm delete \
  --namespace ${HELM_NAMESPACE_NAMESPACE} ${HELM_DEBUG} \
  ${HELM_NAMESPACE_RELEASE} || true

# kubectl create namespace ${HELM_NAMESPACE_NAMESPACE} || true
