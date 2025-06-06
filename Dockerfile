FROM python:3.14-rc-alpine

RUN apk add curl
RUN pip install wfuzz
RUN curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o rockyou.txt -L

ENTRYPOINT ["wfuzz"]
