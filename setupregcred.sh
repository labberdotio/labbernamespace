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

# eval $(aws ecr get-login --no-include-email --profile=ecr-user --region=us-west-2)
# eval $(aws ecr get-login-password --profile=ecr-user --region=us-west-2)
aws ecr get-login-password --profile=ecr-user --region=us-west-2 | docker login --username AWS --password-stdin 513562861795.dkr.ecr.us-west-2.amazonaws.com

kubectl delete secret regcred \
	--namespace=labber

kubectl create secret generic regcred \
	--from-file=.dockerconfigjson=${HOME}/.docker/config.json \
	--type=kubernetes.io/dockerconfigjson \
	--namespace=labber

