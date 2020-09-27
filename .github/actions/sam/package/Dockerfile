FROM golang:alpine
#FROM nikolaik/python-nodejs:python3.8-nodejs12-alpine
RUN apk add --no-cache bash
RUN apk add --no-cache git
RUN apk add --no-cache curl
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew \
&& mkdir ~/.linuxbrew/bin \
&& ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin \
&& eval $(~/.linuxbrew/bin/brew shellenv) \
&& brew --version
RUN brew tap aws/tap
RUN brew install aws-sam-cli
RUN sam --version
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
