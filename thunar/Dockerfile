# Run Libreoffice in a container

FROM alpine:latest
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

RUN apk --no-cache add \
	--repository https://dl-3.alpinelinux.org/alpine/edge/testing \
  adwaita-gtk2-theme \
  dbus \
	thunar

ENV USER tb
RUN adduser -h /home/$USER -D $USER
USER $USER

ENTRYPOINT [ "thunar" ]
