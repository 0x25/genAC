#CA certificat generator en bash

#0================================ 

contenu de l'archive :
- CA/createCAFolder.sh (bash file)
- CA/_tpl (folder)
  
#1================================  

chmod +x createCAFolder.sh

Exemple

./createCAFolder.sh root

va créer un dossier root/ 
avec l'arborescence 

* drwxr-xr-x 2 root root 4096 janv. 28 10:57 certs			<= dossier avec les certificats
* drwxr-xr-x 2 root root 4096 janv. 28 10:57 crl				<= certificate revocation list
* -rw-r--r-- 1 root root    3 janv. 28 10:57 crlnumber
* -rw-r--r-- 1 root root    3 janv. 28 10:57 crlnumber.old
* drwxr-xr-x 2 root root 4096 janv. 28 10:57 csr
* -rwxr-xr-x 1 root root 1852 janv. 28 10:57 genCert.sh		<= script génération d'un cert signé par root
* -rw-r--r-- 1 root root 1706 janv. 28 10:57 genIntCert.sh	<= script génération de cert intermédaire
* -rw-r--r-- 1 root root    0 janv. 28 10:57 index.txt
* -rw-r--r-- 1 root root 3038 janv. 28 10:57 openssl.cnf		<= fichier de conf openssl
* drwxr-xr-x 2 root root 4096 janv. 28 10:57 p12
* drwxr-xr-x 2 root root 4096 janv. 28 10:57 private    		<= private key
* -rwxr-xr-x 1 root root 1030 janv. 28 10:57 revokCrt.sh		<= revoquer un certificat
* -rwxr-xr-x 1 root root  544 janv. 28 10:57 rmCert.sh		<= script supprimer un cert
* -rw-r--r-- 1 root root    3 janv. 28 10:57 serial

#2=======================================

scripts

genCert.sh
- create cert and key
- ./genCert.sh name [nameCA]

auto signé si pas de name CA

genIntCert.sh
- create cert and key
- ./genCert.sh name nameCA

rmCert.sh
- rm CRT form folder
- ./rmCert.sh name




