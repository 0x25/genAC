#!/bin/bash

# rm CRT form folder
# ./rmCert.sh name

if [ "$#" -ne "1" ] ; then

	echo './rmCert.sh name'
	exit
fi

name=$1
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
echo "-----------"
echo "Rm CRT:"
echo "-----------"
echo ""

rm private/${name}_key.${keyExt}
echo "private/"
ls private
rm certs/${name}_crt.${outExt}
echo "certs/"
ls certs
rm csr/${name}_csr.${outExt}
echo "csr/"
ls csr
