cd "%~dp0"
set OPENSSL_CONF=C:\Users\shadr\OpenSSL\bin\openssl.cnf   

openssl req -config openssl.cnf -newkey rsa:4096 -x509 -days 365 -passout pass:"qwerty" -extensions v3_ca -multivalue-rdn -subj /C=RU/L=Moscow/O=HSE/OU=MIEM/CN="HSE MIEM Root CA" -keyout rootCA.key -out rootCA.crt

openssl req -config openssl.cnf -newkey rsa:4096 -passout pass:"qwerty" -multivalue-rdn -subj /C=RU/L=Moscow/O=HSE/OU=MIEM/CN="Group202 CA" -keyout bib202.key -out bib202.csr

openssl req -text -in bib202.csr 

type null > "%CD%\index.txt"

echo 22 > "%CD%\serial"

openssl ca -verbose -config openssl.cnf -extensions v3_mca -cert rootCA.crt -keyfile rootCA.key -days 365 -passin pass:"qwerty" -multivalue-rdn -in bib202.csr -out bib202.crt -batch 

echo 25 > "%CD%\serial"

openssl req -config openssl.cnf -newkey rsa:4096 -passout pass:"qwerty" -multivalue-rdn -subj /C=RU/L=Moscow/O=HSE/OU=MIEM/CN="Aleksey Shadrunov" -keyout shadrunov.key -out shadrunov.csr

openssl ca -verbose -config openssl.cnf -extensions usr_cert -cert bib202.crt -keyfile bib202.key -days 365 -passin pass:"qwerty" -multivalue-rdn -in shadrunov.csr -out shadrunov.crt -batch

pause