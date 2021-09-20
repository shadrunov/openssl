cd "%~dp0"
set OPENSSL_CONF=C:\Users\shadr\OpenSSL\bin\openssl.cnf   

openssl req -newkey rsa:4096 -passout pass:"qwerty" -x509 -days 365 -subj /C=RU/L=Moscow/O=HSE/OU=MIEM/CN="HSE MIEM Root CA" -keyout rootCA.key -out rootCA.crt

openssl req -newkey rsa:4096 -passout pass:"qwerty" -subj /C=RU/L=Moscow/O=HSE/OU=MIEM/CN="Group202 CA" -keyout bib202.key -out bib202.csr


openssl x509 -req -days 365 -passin pass:"qwerty" -CA rootCA.crt -CAkey rootCA.key -set_serial 01 -in bib202.csr -out bib202.crt 

openssl req -newkey rsa:4096 -passout pass:"qwerty" -subj /C=RU/L=Moscow/O=HSE/OU=MIEM/CN="Shadrunov Aleksey" -keyout shadrunov.key -out shadrunov.csr

openssl x509 -req -days 365 -passin pass:"qwerty" -CA bib202.crt -CAkey bib202.key -set_serial 02 -in shadrunov.csr -out shadrunov.crt

pause