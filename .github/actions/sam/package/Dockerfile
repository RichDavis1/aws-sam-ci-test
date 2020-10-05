FROM livingtribunal/go-sam-cli:first 
#FROM golang:1.14.0-alpine

#ENV SAM_CLI_TELEMETRY 0

#RUN apk add bash
#RUN apk add git

#ENV PYTHONUNBUFFERED=1
#RUN apk add --update --no-cache python3-dev && ln -sf python3-dev /usr/bin/python
#RUN python3 -m ensurepip
#RUN pip3 install --no-cache --upgrade pip setuptools

#RUN apk add --no-cache --virtual builddeps gcc musl-dev
#RUN pip install awscli aws-sam-cli

  
RUN sam --version
RUN echo $PATH

ENV CGO_ENABLED=0

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
