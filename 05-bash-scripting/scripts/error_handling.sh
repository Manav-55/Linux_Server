#!/bin/bash

SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/backup"

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

# Create backup directory
if ! mkdir -p "$BACKUP_DIR"; then
    echo "Error: Could not create backup directory."
    exit 2
fi

# Create archive
if tar -czf "$BACKUP_DIR/backup.tar.gz" "$SOURCE_DIR"; then
    echo "Backup completed successfully."
    exit 0
else
    echo "Error: tar failed to create the backup."
    exit 3
fi