USE master;
GO
--House cleaning
IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'ServerViewOnly' AND type = 'R')
BEGIN
    -- Remove Frodo from the role only if they are a member
    IF EXISTS (
        SELECT 1 FROM sys.server_role_members rm
            INNER JOIN sys.server_principals m ON rm.member_principal_id = m.principal_id
            INNER JOIN sys.server_principals r ON rm.role_principal_id   = r.principal_id
        WHERE m.name = N'Frodo' AND r.name = N'ServerViewOnly')
        ALTER SERVER ROLE ServerViewOnly DROP MEMBER Frodo;

    DROP SERVER ROLE ServerViewOnly;
END
IF SUSER_ID (N'Frodo') IS NOT NULL
    DROP LOGIN Frodo;


--Create the login
CREATE LOGIN Frodo WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

--See all logins (need admin rights)
SELECT * FROM sys.sql_logins;

--Now, log in as Frodo in a separate VS Code Window (Duplicate Workspace) and run the below script to verify you can see the databases but not the logins
--Connection string is:
--Data Source=localhost,14333;User ID=Frodo;Password=pa$$Word1;Pooling=False;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Authentication=SqlPassword;Application Name=vscode-mssql;Application Intent=ReadWrite;Command Timeout=30


-- Notice that Frodo can see the databases but not content
-- Frodo doesn't have permissions to do anything with the databases, we will fix that in the next script
