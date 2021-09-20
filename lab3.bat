cd "%~dp0"

openssl x509 -in bib202.crt -out bib202.pem -outform PEM

type bib202.pem >> chain.pem

openssl x509 -in rootCA.crt -out rootCA.pem -outform PEM

type rootCA.pem >> chain.pem

openssl pkcs12 -export -passin pass:"qwerty" -in shadrunov.crt -inkey shadrunov.key -chain -CAfile chain.pem -passout pass:"qwerty" -out packet.p12 

certutil -p "qwerty" -importpfx "packet.p12" NoExport

pause 