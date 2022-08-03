# Docker RabbitMQ tls-gen

simple wrapper for RabbitMQ tls-gen utility

quickly generate certs for dev purposes.

the container will clone the repo inside the /home/tls-gen dir, switch to the basic folder & launch the make command with CN & PASSWORD params

## usage

env variables:

> - **CNAME**: CN of the certificates
>
>   default: **rabbit.local**
>
> - **PASSWD**: cert. password
>
>   default: **bunny**
> - **OUTPUTPATH**: output folder
>
>   default: **/home/export-result**

example:

``` powershell
#build the image
docker build --tag python:certsbuilder .
#generate certs to default export dir mapped to the relative dir $pwd/tls-gen
docker run --name certsbuilder -e CNAME=rabbit.local -e PASSWD=myrabbitpassword --rm -v $pwd/tls-gen:/home/export-result -it python:certsbuilder`

#generate certs to custom dir home/tmp mapped to the relative dir $pwd/tls-gen
docker run --name certsbuilder -e CNAME=rabbit.local -e PASSWD=myrabbitpassword -e OUTPUTPATH=/home/tmp --rm -v $pwd/certs:/home/tmp -it python:certsbuilder`

```


## Architecture / Reqs

- Basic: just enable TLS connection

- Advanced: Enable client certificate Peer Verification
  
  Clients must present a certificate which is signed by a CA which the RabbitMQ server also trusts

- Enable Client Certificate Authentication (no username/password)?

  Used as a mechanism for clients to authenticate with the broker instead of the default username and password mechanism. In order for clients to authenticate with SSL, they must present a certificate to the server which is signed by a trusted CA, and which contains the login username as the Common Name (CN) or Subject Alternative Name (SAN)

## refs

RabbitMQ documentation on how to generate the required certificates using OpenSSH, this repo is a very simple wrapper for the tls-gen tool:

- [rabbitmq/tls-gen](https://github.com/rabbitmq/tls-gen)
- [Rabbitmq automatic certificate-generation](https://www.rabbitmq.com/ssl.html#automated-certificate-generation)
- [Rabbitmq manual certificate-generation](https://www.rabbitmq.com/ssl.html#manual-certificate-generation)

### Notes on installation

- client certificate is only required for Peer Verification. It is also required if you plan on using certificates for client authentication.
- The CA file, which is used to self-sign the certificates, needs to be in the .pem format for RabbitMQ.
- IThe CN or SAN of the server certificate must be set to the name of the host machine on which the broker will be running. The documentation states to use $(hostname), but this should only be used if the machine you are generating the certificate is the same machine on which the broker will be running on.
- Client Certificate Authentication works on the principle of having password-less user logins, and clients authenticating with the broker by providing the username as the CN or SAN on the certificate they supply. Therefore the CN of the Client Certificates should be set to match the username of a passwordless backend user
