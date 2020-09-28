FROM nikolaik/python-nodejs:python3.8-nodejs12-alpine

RUN apk add bash

ENV SAM_CLI_TELEMETRY 0
RUN apk add --no-cache --virtual builddeps gcc musl-dev && \
   pip --no-cache-dir install aws-sam-cli awscli && \
   apk del builddeps
   
#RUN apk --update --no-cache add jq curl bash gcc git make musl-dev libc6-compat tar && \
#  curl https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz | tar -xvzf - -C /usr/local 

RUN go env
RUN go version
ENV GOROOT /usr/local/go
ENV PATH ${PATH}:${GOROOT}/bin
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
