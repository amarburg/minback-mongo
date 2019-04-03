# minback-mongo
**Minio Backup container for MongoDB**

This container provides a trivially simple means to run `mongodump` and fire the results off
to a [Minio][] instance. It is intended to be run in conjunction with a [Kubernetes CronJob][]
to maintain a frequent backup of your critical data with minimal fuss.

## Features
* Dumps a single MongoDB database to an S3 bucket
* Lightweight and short lived
* Simple and readable implementation

## Example
```sh
docker run --rm --env-file backup.env minback/mongo my_db -h mongoserver1
```

#### `backup.env`
```
MINIO_SERVER=https://play.minio.io/
MINIO_ACCESS_KEY=minio
MINIO_SECRET_KEY=miniosecret
MINIO_BUCKET=backups
MONGODUMP_ARGS="--uri=mongodb://user:password@host/database"
DB=database
```

## Configuration
This container is configured using environment variables.

#### `DB=dbname`
Specifies the name of the database.  This is used to name the resulting archive,
but not to configure mongodump, see $MONGODUMP_ARGS

#### `MONGODUMP_ARGS=`
Arguments passed to mongodump.   Needs to specify the host, database(s) and
table(s) to backup.  For example, through the `-d` option or the `--uri`
option.

#### `MINIO_SERVER=https://play.minio.io/`
The Minio server you wish to send backups to.

#### `MINIO_ACCESS_KEY=minio`
The Access Key used to connect to your Minio server.

#### `MINIO_SECRET_KEY=miniosecret`
The Secret Key used to connect to your Minio server.

#### `MINIO_BUCKET=backups`
The Minio bucket you wish to store your backup in.

### `DATE_FORMAT=+%Y-%m-%d`
The date format you would like to use when naming your backup files. Files are named `$DB-$DATE.archive`.

[Kubernetes CronJob]: https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/
[Minio]: https://minio.io/
