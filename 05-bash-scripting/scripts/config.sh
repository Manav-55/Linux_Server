# the configuration file should contain all the varibles.

#! /bin/bash

CONFIG_FILE="config.conf"

# Check if configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found."
    exit 1
fi

# Load configuration
source "$CONFIG_FILE"
echo "Backup Directory: $BACKUP_DIR"
echo "Retention Days : $RETENTION_DAYS"