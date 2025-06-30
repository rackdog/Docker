#!/bin/bash

# Check for the backup file
if [ ! -f hw_backup.sql ]; then
    echo "❌ Backup file 'hw_backup.sql' not found."
    exit 1
fi

MYSQL_CONTAINER="mysql"
MYSQL_ROOT_PASSWORD="crnqNBgZM9-_otAFGwLh2"
HW_DB="hardware"

# Copy the SQL file into the Docker container
echo "📦 Copying backup into Docker container..."
docker cp hw_backup.sql mysql:/tmp/hw_backup.sql

# Run the SQL script inside the container
echo "🛠️  Restoring database inside Docker container..."
docker exec -i mysql sh -c "mysql -uroot -p'${MYSQL_ROOT_PASSWORD}' hardware < /tmp/hw_backup.sql"

# Optional: Clean up the SQL file from the container
echo "🧹 Cleaning up temporary file inside container..."
docker exec mysql rm -f /tmp/hw_backup.sql

echo "✅ Restore complete."
