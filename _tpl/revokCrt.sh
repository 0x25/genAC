#!/bin/bash

# revoke a CRT
# ./revokeCrt.sh name

if [ "$#" -ne "1" ] ; then

	echo './revokeCrt.sh name_XX.pem'
	exit
fi

name=$1
path='.'
conf=$path/openssl.cnf
delay='3650'
#PEM or DER
keyForm='PEM'
#PEM or DER
outForm='PEM'

if [ $keyForm == "PEM" ];then
	keyExt="pem"
else
	keyExt="der"
fi

if [ $outForm == "PEM" ];then
	outExt="pem"
else
	outExt="der"
fi

if [ $name ]; then
        cert='certs/'$name

        if [ -f "$cert" ]; then

                echo "file $cert exit"
        else
                echo "file $cert not exist (FAIL)"
                exit
        fi
fi



echo ""
echo "-----------"
echo "Revoke CRT:"
echo "-----------"
echo ""
#revoke cert
openssl ca -config $conf -revoke $path/certs/${name}

#renew crl
#openssl ca -gencrl -keyfile ca_key -cert ca_crt -out my_crl.pem
openssl ca -config openssl.cnf -gencrl -keyfile private/root_key.pem -cert certs/root_crt.pem -out crl/root.crl

echo ""
echo "-----------"
echo "Show CRL:  "
echo "-----------"
echo ""
openssl crl -text -noout -in crl/root.crl

