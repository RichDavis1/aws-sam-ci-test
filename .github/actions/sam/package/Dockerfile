FROM golang:1.14.0-alpine
#FROM golang

ENV SAM_CLI_TELEMETRY 0

RUN apk add --no-cache bash
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3-dev && ln -sf python3-dev /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

#FROM golang:alpine
#COPY --from=builder /build/ .

RUN apk add --no-cache --virtual builddeps gcc musl-dev && \
   pip --no-cache-dir install aws-sam-cli awscli && \
   apk del builddeps

RUN  adduser -s /bin/bash samcli \
  --disabled-password \
  && echo 'samcli ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

RUN sam --version
	
RUN sam --version
ENV GOOS = "linux"
ENV GO111MODULE=on CGO_ENABLED=0
#ENV CGO_ENABLED=0
ENV GOARCH = "amd64"
#ENV GOPATH /go
#ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
#/usr/local/go/bin

RUN echo $PATH
RUN echo $GOPATH
#ENV PATH "$PATH:/usr/local/go/bin"
#ENV PATH "$PATH:/home/runner/work/aws-sam-ci-test/aws-sam-ci-test/go"
#ENV PATH "$PATH:/go"
RUN echo $PATH
COPY entrypoint.sh /entrypoint.sh


 
ENTRYPOINT ["/entrypoint.sh"]
