FROM alpine:latest
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

ENV USER tb
ENV HOME /home/$USER 

WORKDIR /tmp

RUN apk --no-cache add \
	--repository https://dl-3.alpinelinux.org/alpine/edge/testing \
  git \
  python2 \
  && git clone https://github.com/ranger/ranger.git \
  && apk del git \
  && cd ranger \
  && python setup.py install --optimize=1 \
  && mv ranger /bin \
  && cd .. \
  && rm -rf ranger

RUN adduser -h /home/$USER -D $USER
USER $USER

ENTRYPOINT [ "ranger" ]
