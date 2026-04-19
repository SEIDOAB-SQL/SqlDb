USE master;
GO

--House cleaning
DROP USER IF EXISTS SamUser;
IF SUSER_ID (N'Sam') IS NOT NULL
    DROP LOGIN Sam;

CREATE LOGIN Sam WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;


USE [friends];
GO

CREATE USER SamUser FROM LOGIN Sam;
GRANT CONNECT to SamUser;

--see all users
SELECT * FROM sys.database_principals 
WHERE type_desc = 'SQL_USER'

--GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE to SamUser;

--Now, log in as Sam in a separate VS Code Window (Duplicate Workspace) and run the below script to verify you can see the databases but not the logins
--Connection string is:
--Data Source=localhost,14333;User ID=Sam;Password=pa$$Word1;Pooling=False;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Authentication=SqlPassword;Application Name=vscode-mssql;Application Intent=ReadWrite;Command Timeout=30


--Run below script in Sam Window
--See that you cannot connect to any other database than friends
--And even there you cannot not see any schema objects in friends
/*
USE [friends];
GO

--database scoped principals
SELECT SUSER_SNAME() AS server_principal_name,
       USER_NAME() AS database_principal_name;

--Database based users
SELECT * FROM sys.database_principals
WHERE type_desc = 'SQL_USER'
*/


--House cleaning
--close the duplicate workspace where you are logged in as Sam and run the below script in the admin workspace to clean up the login and user we just created for the demo
DROP USER IF EXISTS SamUser;
IF SUSER_ID (N'Sam') IS NOT NULL
    DROP LOGIN Sam;