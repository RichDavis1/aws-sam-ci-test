FROM golang:alpine
#FROM nikolaik/python-nodejs:python3.8-nodejs12-alpine
RUN apk add --no-cache bash
RUN apk add --no-cache git
RUN apk add --no-cache curl

RUN apk update \
	&& apk --no-cache add bash coreutils curl file g++ grep git libc6-compat make ruby ruby-bigdecimal ruby-etc ruby-fiddle ruby-irb ruby-json ruby-test-unit sudo \
	&& adduser -D -s /bin/bash linuxbrew \
	&& echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers \
	&& ln -s /bin/touch /usr/bin/touch

USER linuxbrew
WORKDIR /home/linuxbrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
	SHELL=/bin/bash \
	USER=linuxbrew

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
	&& HOMEBREW_NO_ANALYTICS=1 brew install -s patchelf \
	&& HOMEBREW_NO_ANALYTICS=1 brew install --ignore-dependencies binutils gmp isl@0.18 libmpc linux-headers mpfr zlib \
	&& (HOMEBREW_NO_ANALYTICS=1 brew install --ignore-dependencies gcc || true) \
	&& HOMEBREW_NO_ANALYTICS=1 brew install glibc \
	&& HOMEBREW_NO_ANALYTICS=1 brew postinstall gcc \
	&& HOMEBREW_NO_ANALYTICS=1 brew remove patchelf \
	&& HOMEBREW_NO_ANALYTICS=1 brew install -s patchelf \
	&& HOMEBREW_NO_ANALYTICS=1 brew config

RUN export PATH=$HOME/.linuxbrew/bin:$PATH
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
