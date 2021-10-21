FROM postgres:14

ENV DEBIAN_FRONTEND noninteractive

ARG WALG_VERSION
ARG WALG_URL="https://github.com/wal-g/wal-g/releases/download/$WALG_VERSION/wal-g.linux-amd64.tar.gz"
ARG WALG_DEST_DIR=/usr/local/bin
ARG WALG_BIN_PATH=$WALG_DEST_DIR/wal-g
ARG PG_CONF=$PGDATA/postgresql.conf

RUN apt-get update && \
    apt-get install -y curl ca-certificates libsodium23 && \
    curl -L $WALG_URL | tar xzf - -C $WALG_DEST_DIR

COPY wal-g /wal-g
