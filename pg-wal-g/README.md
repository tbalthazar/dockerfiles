# Postgres Docker image with Wal-g configured

## Full backup

Has to be scheduled in a cron job:

```shell
docker-compose exec -e PGUSER=nextcloud -- db /wal-g/full-backup.sh
```

## Restore

```shell
docker-compose down
rm -Rf /mnt/xyz/nextcloud/db/var/lib/postgresql/data/*
docker-compose run --rm -- db /wal-g/restore.sh

# https://www.postgresql.org/docs/13/runtime-config-wal.html#RUNTIME-CONFIG-WAL-ARCHIVE-RECOVERY
PIT='2021-02-20 17:13:46'
docker-compose run --rm -- db \
  -c restore_command='wal-g wal-fetch %f %p' \
  -c recovery_target_time="$PIT" \
  -c recovery_target_action='promote' \
  -c recovery_end_command='pg_ctl stop'

docker-compose up
# verify everything works

docker-compose exec -- db wal-g delete everything --confirm
docker-compose exec -- db /wal-g/full-backup.sh
docker-compose exec -- db wal-g wal-verify
```