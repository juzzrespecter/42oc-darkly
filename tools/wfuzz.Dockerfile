FROM ghcr.io/xmendez/wfuzz

RUN apk add curl

RUN curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o rockyou.txt -L
RUN curl https://raw.githubusercontent.com/xmendez/wfuzz/refs/heads/master/wordlist/general/common.txt -o wordlist -L
ENTRYPOINT ["wfuzz"]