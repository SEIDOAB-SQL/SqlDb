#!/bin/bash
# Bash script to install freetext search on SQL Server
# Make script executable: sudo chmod +x ./install-sqlserver-fts.sh
# Run this script with: sudo ./install-sqlserver-fts.sh

# SQL SERVER 2022
##################
echo "Preparing the SQL Server 2022 container..."

# Install curl and gnupg2
echo "Installing curl and gnupg2..."
docker exec -u root sql2022container bash -c "apt-get update && apt-get install -y curl gnupg2"

# Add Microsoft GPG key
echo "Adding Microsoft GPG key..."
docker exec -u root sql2022container bash -c "curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -"

# Add Microsoft SQL Server repository
echo "Adding Microsoft SQL Server package repository..."
docker exec -u root sql2022container bash -c "curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list > /etc/apt/sources.list.d/mssql-server.list"

# Install mssql-server-fts from the repository
echo "Installing mssql-server-fts..."
docker exec -u root sql2022container bash -c "apt-get update && apt-get install -y mssql-server-fts"


echo "Restarting SQL Server container to apply changes..."
docker restart sql2022container
