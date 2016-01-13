function openssl-view-csr(){
	openssl req -text -noout -in $@
}

function openssl-gen-csr(){
	openssl req -new -key $1.key -out $1.csr
}

function openssl-gen-key(){
	openssl genrsa -des3 -out $1.key 2048
}

function openssl-self-sign(){
	openssl x509 -req -days 3650 -in $1.csr -signkey $1.key -out $1.crt
}

function openssl-remove-key(){
	openssl rsa -in $1.key -out $1-nopass.key
}