#!/bin/bash
# chmod +x createCAFolder.sh
# create CA folder for crt private ...

#check argument for bash script
if [ $# -ne 1 ];then
	echo "help : add name after the cmd"
	echo "./createCAFolder.sh <ca_name>"
	exit
fi
#name of cert and folder
name=$1

echo "create folder $name/"

#create arboresence
mkdir $name
mkdir $name/private
mkdir $name/certs
mkdir $name/crl
mkdir $name/csr
mkdir $name/p12

#create file
echo "copie files from _tpl to $name"

cp _tpl/* $name

for i in $name/*.sh; do
	chmod +x $i
done

current_path=$(pwd)
echo "current path $current_path"

#config

ca_name=${name}_crt.pem
key_name=${name}_key.pem
crl_name=${name}.crl
path_name="$current_path/$name" 
echo "path name $path_name"

cp _tpl/openssl.cnf $name/openssl.cnf
#configure openssl variables
sed "s|TPL_PATH|$path_name|" $name/openssl.cnf > $name/tmp
sed "s|TPL_CANAME|$ca_name|" $name/tmp > $name/tmp2
sed "s|TPL_CAKEYNAME|$key_name|" $name/tmp2 > $name/tmp3
sed "s|TPL_CRLNAME|$crl_name|" $name/tmp3 > $name/openssl.cnf

rm $name/tmp*

ls -al $name

#######################
# create CA crt key crl
#######################

name=$1
path="$current_path/$name"
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

echo ""
echo "----------"
echo "Create CA:"
echo "----------"
#create CA key and CA cert
openssl req -new -x509 -days $delay -config $conf -keyform $keyForm -keyout $path/private/${name}_key.${keyExt} -outform $outForm -out $path/certs/${name}_crt.${outExt}


echo "files:"
ls $path/private | grep ${name}_key.${keyExt}
ls $path/certs | grep ${name}_crt.${outExt}

echo ""
echo "-----------"
echo "Create CRL:"
echo "-----------"
# create crl
openssl ca -config $conf -gencrl -keyfile $path/private/${name}_key.${keyExt} -cert $path/certs/${name}_crt.${outExt} -out $path/crl/${name}.crl

echo "file:"
ls $path/crl | grep ${name}.crl
echo""

