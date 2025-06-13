#!/bin/bash
set -e

DOCKER_IMAGE=d-wfuzz

usage="usage: ./init-wfuzz.sh <URL> <BLACKLIST_LEN>"
if [ $# -ne 2 ]; then
    echo $usage >&2
    exit 1
fi
URL=$1
LEN=$2

if ! docker image ls | grep $DOCKER_IMAGE >/dev/null; then
    docker build -t $DOCKER_IMAGE -f wfuzz.Dockerfile .
fi

# --hh 975:  la app enmascara los 404, filtramos por el tamaño de la petición que devuelve un recurso no encontrado
# --hh 1988: filtrado de logeos inválidos
docker run -it $DOCKER_IMAGE -w wordlist --hh $LEN $URL
