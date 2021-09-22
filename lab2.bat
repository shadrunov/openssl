set OPENSSL_CONF= # path without quotes

openssl req -config openssl.conf -newkey rsa:4096 -x509 -days 365 -passout pass:"qwerty" -extensions v3_ca -multivalue-rdn -subj /C=RU/L=City/O=Organization/OU=OU/CN="rootCA" -keyout rootCA.key -out rootCA.pem

openssl req -config openssl.conf -newkey rsa:4096 -passout pass:"qwerty" -multivalue-rdn -subj /C=RU/L=City/O=Organization/OU=OU/CN="mCA" -keyout mCA.key -out mCA.csr


type null > "%CD%\index.txt"

echo 22 > "%CD%\serial"

openssl ca -verbose -config openssl.conf -extensions v3_mca -cert rootCA.pem -keyfile rootCA.key -days 365 -passin pass:"qwerty" -multivalue-rdn -in mCA.csr -out mCA.pem -batch 

echo 25 > "%CD%\serial"

openssl req -config openssl.conf -newkey rsa:4096 -passout pass:"qwerty" -multivalue-rdn -subj /C=RU/L=City/O=Organization/OU=OU/CN="iwtm.demo.lab" -keyout server.key -out server.csr

openssl ca -verbose -config openssl.conf -extensions usr_cert -cert mCA.pem -keyfile mCA.key -days 365 -passin pass:"qwerty" -multivalue-rdn -in server.csr -out server.p -batch

pause