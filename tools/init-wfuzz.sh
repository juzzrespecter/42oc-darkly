#!/bin/bash
set -e

usage="usage: ./init-wfuzz.sh <URL>"
if [ $# -ne 1 ]; then
    echo $usage >&2
    exit 1
fi
URL=$1

if [ ! -f wordlist ]; then
    curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o wordlist -L
fi

# --hh 975: la app enmascara los 404, filtramos por el tamaño de la petición que devuelve un recurso no encontrado
docker run -v $(pwd)/wordlist:/wordlist -it ghcr.io/xmendez/wfuzz wfuzz -w wordlist --hh 1988 $URL
