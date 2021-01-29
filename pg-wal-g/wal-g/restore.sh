#!/bin/bash

set -e

export PGUSER=postgres

wal-g backup-fetch $PGDATA LATEST
touch $PGDATA/recovery.signal