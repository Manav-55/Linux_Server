#! /bin/bash
BACKUP_NAME="etc-backup.tar.gz"
RESTORE_DIR="$HOME/etc-restore"

echo "--started the compression---"
sudo tar -czvf "$BACKUP_NAME" /etc

echo "-----restoring directory------"
mkdir -p "$RESTORE_DIR"
tar -xzvf "$BACKUP_NAME" -C "$RESTORE_DIR"

echo "----Compare the strucuture------"
echo "Original /etc size:"
sudo du -sh /etc
echo "Extracted etc size:"
du -sh "$RESTORE_DIR/etc"

