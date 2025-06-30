#!/usr/bin/env bash
#
# create-hardware-db.sh
#
# Connects to the 'mysql' container as root, creates database+user, grants privileges.

# Configuration (temporary credentials)
MYSQL_CONTAINER="mysql"
MYSQL_ROOT_PASSWORD="crnqNBgZM9-_otAFGwLh2"
HW_DB="hardware"
HW_USER="hw_user"
HW_PASS="TERXvBWQ7nmy7L8pyAoC"

# Run the SQL statements inside the container
docker exec -i "${MYSQL_CONTAINER}" mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" <<EOSQL
-- 1) Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS \`${HW_DB}\`;

-- 2) Create (or update) the user and set its password
CREATE USER IF NOT EXISTS '${HW_USER}'@'%' IDENTIFIED BY '${HW_PASS}'
  /* for MySQL ≥8.0 this will also update the password if the user already exists */;

-- 3) Grant all privileges on the new database
GRANT ALL PRIVILEGES ON \`${HW_DB}\`.* TO '${HW_USER}'@'%';

-- 4) Apply changes
FLUSH PRIVILEGES;
EOSQL

echo "Database '${HW_DB}' and user '${HW_USER}'@'%' created (or updated) successfully."
