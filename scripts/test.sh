#!/usr/bin/env bash

IMAGE=orders

set -ev

SCRIPT_DIR=$(dirname "$0")

if [[ -z "$GROUP" ]] ; then
    echo "Cannot find GROUP env var"
    exit 1
fi

if [[ -z "$COMMIT" ]] ; then
    echo "Cannot find COMMIT env var"
    exit 1
fi

if [[ "$(uname)" == "Darwin" ]]; then
    DOCKER_CMD=docker
else
    DOCKER_CMD="sudo docker"
fi

CODE_DIR=$(cd $SCRIPT_DIR/..; pwd)
REPORT_DIR=$CODE_DIR/reports
echo $CODE_DIR

if [[ -z "$COVERALLS_TOKEN" ]] ; then
    echo "Unit Test without coverage"
    $DOCKER_CMD run --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $CODE_DIR:/usr/src/mymaven \
    -w /usr/src/mymaven \
    maven:3.5.2-jdk-8 mvn test
else
    $DOCKER_CMD run --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $CODE_DIR:/usr/src/mymaven \
    -w /usr/src/mymaven \
    maven:3.5.2-jdk-8 \
    mvn -DrepoToken=$COVERALLS_TOKEN verify jacoco:report coveralls:report
fi


