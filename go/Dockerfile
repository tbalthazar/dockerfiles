FROM golang:latest
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

ENV USER user
ENV HOME /home/$USER
ENV GOPATH $HOME/go
ENV GOCACHE $HOME/.cache/go-build

RUN useradd -s /bin/bash --create-home --home-dir $HOME $USER \
  && mkdir -p $GOPATH \
  && mkdir -p $GOCACHE \
  && chown -R $USER:$USER $HOME

WORKDIR $HOME
USER $USER
