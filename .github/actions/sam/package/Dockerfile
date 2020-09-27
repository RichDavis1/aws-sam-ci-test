#FROM golang:alpine
FROM nikolaik/python-nodejs:python3.8-nodejs12-alpine

ENV SAM_CLI_TELEMETRY 0
#RUN sudo apt-get update
#RUN sudo apt-get install golang-go
RUN apk --update --no-cache add jq curl bash gcc git make musl-dev libc6-compat tar && \
  curl https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz | tar -xvzf - -C /usr/local 
#ENV PATH="/usr/local/go/bin:$PATH"
#ENV GOPATH=/opt/go/ 
#ENV PATH=$PATH:$GOPATH/bin   
#ENV GOROOT /usr/local/go
#ENV PATH ${PATH}:${GOROOT}/bin
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
