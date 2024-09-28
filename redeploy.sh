#!/usr/bin/env bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo "This Dir: $THIS_DIR"
source $THIS_DIR/settings.sh

cp ${THIS_DIR}/labber/${HELM_VALUES} ${THIS_DIR}/labber/values.yaml
cp ${THIS_DIR}/labbernamespace/${HELM_VALUES} ${THIS_DIR}/labbernamespace/values.yaml

export GFSNAMESPACE="${1}"
if [ -z "${GFSNAMESPACE}" ]; then
  echo "Error: No namespace given"
  echo "Usage: ./redeploy_labbernamespace.sh NAMESPACE"
  exit 0
fi

echo "Redeploying services for namespace: ${GFSNAMESPACE}"

export HELM_NAMESPACE_NAMESPACE="${HELM_NAMESPACE}"
export HELM_NAMESPACE_RELEASE="${GFSNAMESPACE}-${HELM_RELEASE}"
# export HELM_NAMESPACE_DOMAIN="${GFSNAMESPACE}.${HELM_DOMAIN}"
export HELM_NAMESPACE_DOMAIN="${HELM_DOMAIN}"

# kubectl create namespace ${HELM_NAMESPACE_NAMESPACE} || true

helm upgrade \
  --namespace ${HELM_NAMESPACE_NAMESPACE} ${HELM_DEBUG} \
  --values "${THIS_DIR}/labber/${HELM_VALUES}" \
  --set global.domain.name="${HELM_NAMESPACE_DOMAIN}" \
  --set global.gfsnamespace="${GFSNAMESPACE}" \
  ${HELM_NAMESPACE_RELEASE} labbernamespace
