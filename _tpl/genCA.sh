#!/bin/bash

# create CA cert CA key and CRL file
# ./genCA.sh name

if [ "$#" -ne "1" ] ; then

	echo './genCA.sh name'
	exit
fi

name=$1
conf='conf/openssl.cnf'
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

echo ""
echo "----------"
echo "Create CA:"
echo "----------"
#create CA key and CA cert
openssl req -new -x509 -days $delay -config $conf -keyform $keyForm -keyout private/${name}_CA_key.${keyExt} -outform $outForm -out certs/${name}_CA_crt.${outExt}

echo "files:"
ls private | grep ${name}_CA_key.${keyExt}
ls certs | grep ${name}_CA_crt.${outExt}

echo ""
echo "-----------"
echo "Create CRL:"
echo "-----------"
# create crl
openssl ca -config $conf -gencrl -keyfile private/${name}_CA_key.${keyExt} -cert certs/${name}_CA_crt.${outExt} -out crl/${name}.crl

echo "file:"
ls crl | grep ${name}.crl
echo""
