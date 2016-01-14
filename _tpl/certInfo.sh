#!/bin/bash
#openssl x509 -in certificate.crt -text -noout

if [ -z $1 ];then

echo 'usage :'
echo "$0 /path/to.crt"

exit
fi

openssl x509 -in $1 -text -noout
