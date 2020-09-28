FROM golang:1.14.0-alpine

ENV SAM_CLI_TELEMETRY 0

RUN apk add bash
RUN apk add git

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3-dev && ln -sf python3-dev /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN apk add --no-cache --virtual builddeps gcc musl-dev && \
   pip --no-cache-dir install aws-sam-cli awscli && \
   apk del builddeps

RUN  adduser -s /bin/bash samcli \
  --disabled-password \
  && echo 'samcli ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
	
RUN sam --version

ENV GOOS = "linux"
ENV GO111MODULE=on CGO_ENABLED=0
#ENV CGO_ENABLED=0
ENV GOARCH = "amd64"

RUN echo $INPUT_DIRECTORY
RUN echo $GITHUB_WORKSPACE
RUN echo "${INPUT_DIRECTORY}"
RUN echo GITHUB_WORKSPACE

RUN git clone https://github.com/RichDavis1/aws-sam-ci-test.git
#RUN echo "$PWD"
#RUN cd ../sam
#RUN cd ./.github
#RUN cd ./.sam-testaroni
#COPY ./../.sam-testaroni .
#COPY ./sam-testaroni .
COPY . .
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
