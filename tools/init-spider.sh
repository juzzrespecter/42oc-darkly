#!/bin/bash
set -e

usage="usage: ./init-spider.sh <IP>"
if [ $# -ne 1 ]; then
    echo $usage >&2
    exit 1
fi
IP=$1

if ! docker image ls | grep gospider >/dev/null; then
    git clone https://github.com/jaeles-project/gospider.git
    docker build -t gospider:latest gospider
    rm -rfv gospider
fi

docker run --rm gospider -v -s http://$IP --blacklist "html5shiv.js|.hidden" -d 3
