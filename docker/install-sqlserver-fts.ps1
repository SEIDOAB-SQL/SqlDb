# PowerShell script to install freetext search on SQL Server

# To allow Windows to execute .ps1 files, 
# In powerShell execute below once:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# Run this script with: .\install-sqlserver-fts.ps1

# SQL SERVER 2022
##################
Write-Host "Preparing the SQL Server 2022 container..."

# Install curl and gnupg2
Write-Host "Installing curl and gnupg2..."
docker exec -u root sql2022container bash -c "apt-get update && apt-get install -y curl gnupg2"

# Add Microsoft GPG key
Write-Host "Adding Microsoft GPG key..."
docker exec -u root sql2022container bash -c "curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -"

# Add Microsoft SQL Server repository
Write-Host "Adding Microsoft SQL Server package repository..."
docker exec -u root sql2022container bash -c "curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list > /etc/apt/sources.list.d/mssql-server.list"

# Install mssql-server-fts from the repository
Write-Host "Installing mssql-server-fts..."
docker exec -u root sql2022container bash -c "apt-get update && apt-get install -y mssql-server-fts"

Write-Host "Restarting SQL Server container to apply changes..."
docker restart sql2022container
