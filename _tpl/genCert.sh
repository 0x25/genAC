#!/bin/bash

# create cert and key
# ./genCert.sh name [nameCA]

# /!\ cert same PEM/DER format as CA !!

if [ "$#" -lt "1" ] ; then

        echo './genCert.sh name [nameCA]'
        exit
fi

name=$1
path='.'
conf=$path/openssl.cnf
keyForm='PEM'
outForm='PEM'
delay='3650'


if [ $keyForm == "PEM" ]; then
        keyExt="pem"
else
        keyExt="der"
fi

if [ $outForm == "PEM" ]; then
        outExt="pem"
else
        outExt="der"
fi


#check $2 file cert


if [ $2 ]; then
	CAfile='certs/'$2'_crt.'$outExt

	if [ -f "$CAfile" ]; then

		echo "file $CAfile exit"
	else
		echo "file $CAfile not exist (FAIL)"
		exit
	fi
fi


echo ""
echo "-------------------"
echo "Create CSR and KEY:"
echo "-------------------"

#create csr and key
openssl req -new -config $conf -extensions v3_req -keyform $keyForm -keyout $path/private/${name}_key.${keyExt} -outform $outForm -out $path/csr/${name}_csr.${outExt} -nodes

echo "files :"
ls $path/private | grep ${name}_key.${keyExt}
ls $path/csr | grep ${name}_csr.${outExt}

echo ""
echo "-----------"
echo "Create CRT:"
echo "-----------"

if [ $2 ];then

#sign
	echo "crt signed with $2"
	ca=$2
	openssl x509 -days $delay -extfile openssl.cnf -extensions v3_req -CA $path/certs/${ca}_crt.${outExt} -CAkey $path/private/${ca}_key.${keyExt} -req -in csr/${name}_csr.pem -outform $outForm -out $path/certs/${name}_crt.${outExt} -CAserial serial
else

#no sign
	echo "self signed crt"
	openssl x509 -days $delay -extfile openssl.cnf -extensions v3_req -req -signkey $path/private/${name}_key.${keyExt} -in $path/csr/${name}_csr.${outExt} -outform $outForm -out $path/certs/${name}_crt.${outExt} -CAserial serial


fi

echo "file :"
ls $path/certs/${name}_crt.${outExt}
echo ""

#convert cert and key in p12

openssl pkcs12 -export -out p12/$name.p12 -in certs/${name}_crt.$outExt -inkey private/${name}_key.pem
