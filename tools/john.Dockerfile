FROM debian:bookworm

RUN apt update && apt install -y git curl build-essential libssl-dev zlib1g-dev yasm
RUN git clone https://github.com/openwall/john -b bleeding-jumbo john-jumbo
RUN cd john-jumbo/src && \
	./configure && make -s clean && make -sj$(nproc)
RUN curl -L https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o rockyou.txt

VOLUME /passwd.txt

ENTRYPOINT ["/john-jumbo/run/john", "--format=raw-md5", "--wordlist=rockyou.txt", "/passwd.txt"]
