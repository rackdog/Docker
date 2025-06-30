#!/bin/bash

# Load environment variables from .env
set -a
source .env
set +a

# --- Configuration ---
SSH_USER="ubuntu"
SSH_HOST="158.51.207.98"
SSH_PORT="2234"

REMOTE_BACKUP_PATH="/tmp/hw_backup.sql"
LOCAL_BACKUP_PATH="./hw_backup.sql"

# --- Run mysqldump on the remote server ---
echo "Creating MySQL dump on remote server..."
ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" \
    "mysqldump --no-tablespaces -u$MYSQL_USER -p'$MYSQL_PASSWORD' $MYSQL_DATABASE > $REMOTE_BACKUP_PATH"

# --- Download the dump file to local machine ---
echo "Downloading backup file to local machine..."
scp -P "$SSH_PORT" "$SSH_USER@$SSH_HOST:$REMOTE_BACKUP_PATH" "$LOCAL_BACKUP_PATH"

# --- Clean up the remote dump file ---
echo "Cleaning up remote backup file..."
ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" "rm -f $REMOTE_BACKUP_PATH"

echo "✅ Backup complete: $LOCAL_BACKUP_PATH"
