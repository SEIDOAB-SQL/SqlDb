#!/bin/bash
# Bash script to install and run SQL Server, and PostgreSQL Docker containers

#To make the .sh file executable
#sudo chmod +x ./install_sql_docker.sh

# Run this script with: ./install_sql_docker.sh

# SQL SERVER 2022
##################
echo "Setting up SQL Server 2022 container..."

# Pull the container image to my computer
docker pull mcr.microsoft.com/mssql/server:2022-latest

# Install and run the container 
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<replace with password>" -p 14333:1433 --name sql2022container --hostname sql2022 -d mcr.microsoft.com/mssql/server:2022-latest

echo "SQL Server 2022 connection string:"
echo "Data Source=localhost,14333;Persist Security Info=True;User ID=sa;Password=<replace with password>;Pooling=False;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Authentication=SqlPassword;Application Name=vscode-mssql;Connect Retry Count=1;Connect Retry Interval=10;Command Timeout=30;"


# PostgreSQL
############
echo
echo "Setting up PostgreSQL container..."

# Pull the container image to my computer
docker pull postgres

# Create a database container and run the docker 
docker run --name postgrescontainer -e POSTGRES_PASSWORD=<replace with password> -d -p 5432:5432 postgres

echo "PostgreSQL connection string:"
echo "Server=localhost;Port=5432;User Id=postgres;Password=<replace with password>;"

echo
echo "All database containers have been created and started!"
echo "You can check the status with: docker ps"
