#!/bin/bash

wal-g backup-push $PGDATA
wal-g delete retain FIND_FULL 30 --confirm