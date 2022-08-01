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

refs:

- [rabbitmq/tls-gen](https://github.com/rabbitmq/tls-gen)
- [Rabbitmq automatic certificate-generation](https://www.rabbitmq.com/ssl.html#automated-certificate-generation)
- [Rabbitmq manual certificate-generation](https://www.rabbitmq.com/ssl.html#manual-certificate-generation)
