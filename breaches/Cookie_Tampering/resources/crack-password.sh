#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Provide a hash to attempt cracking." >&2
    exit 1
fi

echo $1 > passwd.txt
docker run --rm -v ./passwd.txt:/passwd.txt d-john
