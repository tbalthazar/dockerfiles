FROM alpine:latest
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

RUN apk --no-cache add \
	--repository https://dl-3.alpinelinux.org/alpine/edge/testing \
	pdftk

ENTRYPOINT [ "pdftk" ]
