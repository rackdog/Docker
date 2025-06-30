#!/bin/bash

# Load environment variables from .env
set -a
source .env
set +a

# Check for the backup file
if [ ! -f hw_backup.sql ]; then
    echo "❌ Backup file 'hw_backup.sql' not found."
    exit 1
fi

# Copy the SQL file into the Docker container
echo "📦 Copying backup into Docker container..."
docker cp hw_backup.sql mysql:/tmp/hw_backup.sql

# Run the SQL script inside the container
echo "🛠️  Restoring database inside Docker container..."
docker exec -i mysql sh -c "mysql -u$MYSQL_USER -p'$MYSQL_PASSWORD' $MYSQL_DATABASE < /tmp/hw_backup.sql"

# Optional: Clean up the SQL file from the container
echo "🧹 Cleaning up temporary file inside container..."
docker exec mysql rm -f /tmp/hw_backup.sql

echo "✅ Restore complete."
