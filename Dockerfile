FROM python:latest

RUN apt update && apt -y install openssh-client git make

WORKDIR /home
ENV PASSWD bunny
ENV CNAME rabbit.local
ENV OUTPUTPATH /home/export-result
COPY ./generate-certs.sh .


CMD ["./generate-certs.sh"]