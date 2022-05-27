#!/bin/sh

SCRIPT_DIR=`dirname $0`
C_ORG=cubetiq
C_IMG=jdk
C_TAG=17-ubuntu
C_ROOT=${C_ORG}/${C_IMG}:${C_TAG}

echo "Starting build for CUBETIQ JDK: ${C_ROOT}"
docker build -f $SCRIPT_DIR/Dockerfile  . -t ${C_ROOT}

echo "Publishing to DockerHub with ${C_ROOT}"
docker push ${C_ROOT}