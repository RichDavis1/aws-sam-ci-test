FROM python:3.8-alpine as builder

RUN apk add --no-cache --virtual builddeps gcc musl-dev && \
   pip --no-cache-dir install aws-sam-cli awscli && \
   apk del builddeps

RUN	adduser -s /bin/bash samcli \
	--disabled-password \
	&& echo 'samcli ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

RUN sam --version

COPY . .
#USER samcli

#WORKDIR /home/samcli

FROM golang:alpine
COPY --from=builder . .
RUN apk add --no-cache bash
RUN apk add --no-cache --virtual builddeps gcc musl-dev && \
   pip --no-cache-dir install aws-sam-cli awscli && \
   apk del builddeps

RUN	adduser -s /bin/bash samcli \
	--disabled-password \
	&& echo 'samcli ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
	
RUN sam --version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
