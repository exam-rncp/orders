#!/usr/bin/env bash

IMAGE=orders

set -ev

SCRIPT_DIR=$(dirname "$0")
GROUP=f3lin
COMMIT=test

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
# $DOCKER_CMD run --rm -v $HOME/.m2:/root/.m2 -v $CODE_DIR:/usr/src/mymaven -w /usr/src/mymaven maven:3.5.2-jdk-8 mvn -DskipTests package

# $DOCKER_CMD run --rm \
#     -v $HOME/.m2:/root/.m2 \
#     -v $CODE_DIR:/usr/src/mymaven \
#     -v $REPORT_DIR:/usr/src/mymaven/target \
#     -w /usr/src/mymaven \
#     maven:3.5.2-jdk-8 mvn test

# cp $REPORT_DIR/jacoco.exec $CODE_DIR
# rm $REPORT_DIR/.

COVERALLS_TOKEN=

$DOCKER_CMD run --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $CODE_DIR:/usr/src/mymaven \
    -w /usr/src/mymaven \
    maven:3.5.2-jdk-8 \
    mvn -DrepoToken=$COVERALLS_TOKEN verify jacoco:report coveralls:report


# cp -r $CODE_DIR/docker $CODE_DIR/target/docker/
# cp -r $CODE_DIR/target/*.jar $CODE_DIR/target/docker/${IMAGE}

# cp $CODE_DIR/target/*.jar $CODE_DIR/docker/${IMAGE}

# REPO=${GROUP}/${IMAGE}
#     $DOCKER_CMD build -t ${REPO}:${COMMIT} $CODE_DIR/docker/${IMAGE};
