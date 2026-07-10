#!/bin/bash

BACKUP_DIR="/home/$USER/backup"

echo "Searching for backup files older than 7 days..."

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory not found."
    exit 1
fi

FILE_COUNT=$(find "$BACKUP_DIR" -type f -mtime +7 | wc -l)

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No backup files older than 7 days were found."
else
    echo "Deleting $FILE_COUNT backup file(s)..."

    find "$BACKUP_DIR" -type f -mtime +7 -print -delete

    echo "Cleanup completed successfully."
fi