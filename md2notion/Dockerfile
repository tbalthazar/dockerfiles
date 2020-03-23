FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 \
  python3-pip \
  python3-setuptools \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install md2notion
