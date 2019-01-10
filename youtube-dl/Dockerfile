FROM alpine

RUN apk --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  --no-cache add \
  curl \
  python

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl \
  && chmod a+rx /usr/local/bin/youtube-dl
