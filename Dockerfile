FROM python:latest

RUN apt update && apt -y install openssh-client git make

WORKDIR /home
ENV PASSWD bunny
ENV CNAME rabbit.local
COPY ./generate-certs.sh .


CMD ["./generate-certs.sh"]