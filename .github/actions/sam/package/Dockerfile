FROM golang:alpine
#FROM nikolaik/python-nodejs:python3.8-nodejs12-alpine
RUN apk add --no-cache bash

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip

RUN pip3 install --upgrade pip setuptools
#RUN pip install sys
#RUN pip install setuptools
#RUN pip install tokenize
RUN pip freeze > requirements.txt
RUN pip install -r requirements.txt
RUN pip install wheel
RUN export PYTHONPATH="$PYTHONPATH:/app"
ENV PYTHONPATH="$PYTHONPATH:/app"
#RUN pip install aws-sam-cli
#ENV SAM_CLI_TELEMETRY 0
#RUN sudo apt-get update
#RUN sudo apt-get install golang-go
#RUN apk --update --no-cache add jq curl bash gcc git make musl-dev libc6-compat tar && \
#  curl https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz | tar -xvzf - -C /usr/local 
#ENV GOROOT /usr/local/go
#ENV PATH ${PATH}:${GOROOT}/bin

#ENV PATH="/usr/local/go/bin:$PATH"
#ENV GOPATH=/opt/go/ 
#ENV PATH=$PATH:$GOPATH/bin   
#ENV GOROOT /usr/local/go
#ENV PATH ${PATH}:${GOROOT}/bin
#ENV GOROOT /usr/lib/go
#ENV GOPATH /go
#ENV PATH /go/bin:$PATH


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
