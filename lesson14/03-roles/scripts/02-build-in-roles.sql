USE [friends];
GO


--Create a login
CREATE LOGIN Frodo WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=friends, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

--Create a user for the login
CREATE USER FrodoUser FROM LOGIN Frodo;

--Add FrodoUser to an existing role
ALTER ROLE db_datareader ADD MEMBER FrodoUser;

--Now, log in as Frodo in a separate VS Code Window (Duplicate Workspace) and run the below script to verify you can see the databases but not the logins
--Connection string is:
--Data Source=localhost,14333;User ID=Frodo;Password=pa$$Word1;Pooling=False;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Authentication=SqlPassword;Application Name=vscode-mssql;Application Intent=ReadWrite;Command Timeout=30


-- Notice that Frodo can see the databases and do SELECT on any database table
-- Try modifying any table data
-- Frodo doesn't have permissions to modify any database


--close the duplicate workspace where you are logged in as Frodo and run the below script in the admin workspace to clean up the login and server role we just created for the demo
--House cleaning


--Cleanup
DROP USER IF EXISTS FrodoUser;
IF SUSER_ID (N'Frodo') IS NOT NULL
    DROP LOGIN Frodo;
