#!/bin/bash

set -e

usage="usage: init-john.sh <PWD_FILE>"
if [ $# -ne 1 ]; then
    echo $usage >&2
    exit 1;
fi
DOCKER_IMAGE=d-john
if ! docker image ls | grep $DOCKER_IMAGE >/dev/null; then
    docker build -t $DOCKER_IMAGE -f john.Dockerfile .
fi
PWD_FILE=$1
docker run -v ./$1:/passwd.txt $DOCKER_IMAGE 