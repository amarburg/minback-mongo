#! /bin/bash
set -e -o pipefail

mc config host add mongodb "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" "$MINIO_API_VERSION" > /dev/null

ARCHIVE="${MINIO_BUCKET}/mongodump-$DB-$(date $DATE_FORMAT).archive"

echo "Dumping to $ARCHIVE"

mongodump $MONGODUMP_ARGS  --archive | mc pipe "mongodb/$ARCHIVE" || { echo "Backup failed"; mc rm "mongodb/$ARCHIVE"; exit 1; }

echo "Backup complete"
