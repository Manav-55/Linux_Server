#! /bin/bash

SOURCE_DIR="/etc"
BACKUP_DIR="$HOME/backups"
TODAY=$(date +"%Y-%m-%d")
ARCHIVE_NAME="backup_$TODAY.tar.gz"

echo "Source Directory: $SOURCE_DIR"
echo "Backup Directory: $BACKUP_DIR"
echo "Today date: $TODAY"
echo "Archive Name: $ARCHIVE_NAME"