#!/usr/bin/env bash

IMAGE=orders

set -ev

SCRIPT_DIR=$(dirname "$0")
# GROUP=f3lin
# TAG=test

if [[ -z "$GROUP" ]] ; then
    echo "Cannot find GROUP env var"
    exit 1
fi

if [[ -z "$TAG" ]] ; then
    echo "Cannot find TAG env var"
    exit 1
fi

# no need for github action
# if [[ "$(uname)" == "Darwin" ]]; then
#     DOCKER_CMD=docker
# else
#     DOCKER_CMD="sudo docker"
# fi

CODE_DIR=$(cd $SCRIPT_DIR/..; pwd)
REPORT_DIR=$CODE_DIR/reports
echo $CODE_DIR
$DOCKER_CMD run --rm -v $HOME/.m2:/root/.m2 -v $CODE_DIR:/usr/src/mymaven -w /usr/src/mymaven maven:3.5.2-jdk-8 mvn -DskipTests package

cp $CODE_DIR/target/*.jar $CODE_DIR/docker/${IMAGE}

REPO=${GROUP}/${IMAGE}
$DOCKER_CMD build -t ${REPO}:${TAG} $CODE_DIR/docker/${IMAGE};
