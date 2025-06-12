#!/bin/bash
set -e

usage="usage: ./init-wfuzz.sh <URL> <BLACKLIST_LEN>"
if [ $# -ne 2 ]; then
    echo $usage >&2
    exit 1
fi
URL=$1
LEN=$2

if [ ! -f wordlist ]; then
    curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o wordlist -L
fi

# --hh 975:  la app enmascara los 404, filtramos por el tamaño de la petición que devuelve un recurso no encontrado
# --hh 1988: filtrado de logeos inválidos
docker run -v $(pwd)/wordlist:/wordlist -it ghcr.io/xmendez/wfuzz wfuzz -w wordlist --hh $LEN $URL
