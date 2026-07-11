#!/bin/bash


# Configuration
BACKUP_DIR="$HOME/backup"
LOG_FILE="$BACKUP_DIR/backup.log"
RETENTION_DAYS=7

SOURCE_DIRS=(
    "$HOME/Documents"
    "$HOME/Pictures"
    "$HOME/Desktop"
)

echo "------Backup Script Started --------"

# Create backup directory
if ! mkdir -p "$BACKUP_DIR"; then
    echo "Error: Could not create backup directory."
    exit 1
fi

# Create log file if it doesn't exist
touch "$LOG_FILE"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup Started" >> "$LOG_FILE"

# Loop through each source directory
for DIR in "${SOURCE_DIRS[@]}"
do
    DIR_NAME=$(basename "$DIR")

    echo "--------------------------------"
    echo "Processing: $DIR_NAME"

    # Create source directory if it doesn't exist
    mkdir -p "$DIR"

    # Create a sample file
    echo "This is a sample file inside $DIR_NAME." > "$DIR/sample.txt"

    # Timestamp
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

    # Backup filename
    ARCHIVE="$BACKUP_DIR/${DIR_NAME}_${TIMESTAMP}.tar.gz"

    # Compress directory
    if tar -czf "$ARCHIVE" "$DIR"; then
        echo "✓ $DIR_NAME backed up successfully."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS - $DIR_NAME" >> "$LOG_FILE"
    else
        echo "✗ Failed to back up $DIR_NAME."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - FAILED - $DIR_NAME" >> "$LOG_FILE"
    fi
done

echo "--------------------------------"

# Delete backups older than retention period
echo "Removing backups older than $RETENTION_DAYS days..."

find "$BACKUP_DIR" -name "*.tar.gz" -mtime +"$RETENTION_DAYS" -delete

echo "$(date '+%Y-%m-%d %H:%M:%S') - Old backups cleaned." >> "$LOG_FILE"

echo "Backup process completed."

echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup Finished" >> "$LOG_FILE"

exit 0