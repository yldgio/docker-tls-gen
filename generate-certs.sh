#!/bin/bash
chmod +x generate-certs.sh
git clone https://github.com/rabbitmq/tls-gen tls-gen
cd tls-gen/basic && make PASSWORD=$PASSWD CN=$CNAME

mkdir $OUTPUTPATH
cp /home/tls-gen/basic/result/* $OUTPUTPATH
