# Postgres Docker image with Wal-g configured

- the image is built from postgres:13, with wal-g added
- the container must be started with the appropriate pg config args so that wal-g is configured in the container
- I still have to find a way to run a cron to perform a full backup
- the restore script outlines the steps required to restore from a backup:
  - run the restore script from inside the container (it fetches the backup and touch the recovery file)
  - run postgres with the appropriate pg config args to restore things