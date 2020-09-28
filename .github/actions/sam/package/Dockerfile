FROM golang:1.14.0-alpine
#FROM golang
LABEL maintainer="Shaun Jackman <sjackman@gmail.com>"
LABEL name="linuxbrew/alpine"

RUN apk add bash
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

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
RUN test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
RUN test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
RUN echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

RUN brew --version
RUN brew brew tap aws/tap
RUN brew install aws-sam-cli
RUN sam --version

  
  
  
#ENV SAM_CLI_TELEMETRY 0

#RUN apk add --no-cache 


#ENV PYTHONUNBUFFERED=1
#UN apk add --update --no-cache python3-dev && ln -sf python3-dev /usr/bin/python
#UN python3 -m ensurepip
#UN pip3 install --no-cache --upgrade pip setuptools

#FROM golang:alpine
#COPY --from=builder /build/ .

#UN apk add --no-cache --virtual builddeps gcc musl-dev && \
#   pip --no-cache-dir install aws-sam-cli awscli && \
#   apk del builddeps

#UN  adduser -s /bin/bash samcli \
#  --disabled-password \
#  && echo 'samcli ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

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
RUN echo "export PATH=/usr/local/go/bin:${PATH}" >> /root/.bashrc
ENV PATH  "$PATH:/usr/local/go"
#ENV PATH "$PATH:/usr/local/go/bin"
#ENV PATH "$PATH:/home/runner/work/aws-sam-ci-test/aws-sam-ci-test/go"
#ENV PATH "$PATH:/go"
RUN echo $PATH

COPY entrypoint.sh /entrypoint.sh


 
ENTRYPOINT ["/entrypoint.sh"]
