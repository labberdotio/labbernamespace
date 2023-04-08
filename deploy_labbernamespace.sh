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
source $THIS_DIR/common.sh

export GFSNAMESPACE="buildkite"
# export GFSNAMESPACE="snagger"

export HELM_NAMESPACE_NAMESPACE="${HELM_NAMESPACE}"
export HELM_NAMESPACE_RELEASE="${GFSNAMESPACE}-${HELM_RELEASE}"
# export HELM_NAMESPACE_DOMAIN="${GFSNAMESPACE}.${HELM_DOMAIN}"
export HELM_NAMESPACE_DOMAIN="${HELM_DOMAIN}"

kubectl create namespace ${HELM_NAMESPACE_NAMESPACE} || true

# cp ${THIS_DIR}/labbernamespace/${HELM_VALUES} ${THIS_DIR}/labbernamespace/values.yaml

helm install \
  --namespace ${HELM_NAMESPACE_NAMESPACE} ${HELM_DEBUG} \
  --values "${THIS_DIR}/labbernamespace/${HELM_VALUES}" \
  --set global.domain.name="${HELM_NAMESPACE_DOMAIN}" \
  --set global.gfsnamespace="${GFSNAMESPACE}" \
  ${HELM_NAMESPACE_RELEASE} labbernamespace
