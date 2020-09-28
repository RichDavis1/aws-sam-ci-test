#FROM golang:1.14.0-alpine
FROM golang

RUN apt-get update \
  && apt-get install -y --no-install-recommends software-properties-common \
  && add-apt-repository -y ppa:git-core/ppa \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    file \
    fonts-dejavu-core \
    g++ \
    git \
    less \
    libz-dev \
    locales \
    make \
    netbase \
    openssh-client \
    patch \
    sudo \
    uuid-runtime \
    tzdata \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -f UTF-8 en_US.UTF-8 \
  && useradd -m -s /bin/bash linuxbrew \
  && echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

COPY . /home/linuxbrew/.linuxbrew/Homebrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH
WORKDIR /home/linuxbrew

# hadolint ignore=DL3003
RUN cd /home/linuxbrew/.linuxbrew \
  && mkdir -p bin etc include lib opt sbin share var/homebrew/linked Cellar \
  && ln -s ../Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/ \
  && git -C /home/linuxbrew/.linuxbrew/Homebrew remote set-url origin https://github.com/Homebrew/brew \
  && git -C /home/linuxbrew/.linuxbrew/Homebrew fetch origin \
  && HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_AUTO_UPDATE=1 brew tap homebrew/core \
  && brew install-bundler-gems \
  && brew cleanup \
  && { git -C /home/linuxbrew/.linuxbrew/Homebrew config --unset gc.auto; true; } \
  && { git -C /home/linuxbrew/.linuxbrew/Homebrew config --unset homebrew.devcmdrun; true; } \
  && rm -rf ~/.cache \
  && chown -R linuxbrew: /home/linuxbrew/.linuxbrew \
  && chmod -R g+w,o-w /home/linuxbrew/.linuxbrew
  
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
