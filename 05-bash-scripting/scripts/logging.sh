#!/bin/bash

LOG_FILE="backup.log"

# Function to write messages to the log file
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Create log file if it doesn't exist
touch "$LOG_FILE"

log_message "Backup started."

echo "Creating backup directory..."
mkdir -p backup

if [ $? -eq 0 ]; then
    log_message "Backup directory created successfully."
else
    log_message "ERROR: Failed to create backup directory."
    exit 1
fi

echo "Creating sample.txt..."
echo "This is a sample text." > backup/sample.txt

if [ $? -eq 0 ]; then
    log_message "sample.txt created successfully."
else
    log_message "ERROR: Failed to create sample.txt."
    exit 1
fi

log_message "Backup completed successfully."

echo "Done! Check backup.log for details."