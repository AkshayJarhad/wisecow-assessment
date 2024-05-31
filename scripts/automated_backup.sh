#!/bin/bash

SOURCE_DIR="/path/to/source"
DEST_DIR="/path/to/destination"
BACKUP_NAME="backup-$(date +%Y%m%d%H%M%S).tar.gz"

# Create backup
tar -czf $DEST_DIR/$BACKUP_NAME $SOURCE_DIR

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $DEST_DIR/$BACKUP_NAME" >> /var/log/backup.log
else
    echo "Backup failed" >> /var/log/backup.log
fi

