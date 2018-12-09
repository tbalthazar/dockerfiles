FROM debian:buster-slim
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
	curl \
	vim \
	--no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://get.docker.com | sh
