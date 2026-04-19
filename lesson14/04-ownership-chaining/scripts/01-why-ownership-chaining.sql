USE [friends];
GO

--House cleaning
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'gstUsrRole' AND type = 'R')
BEGIN
    ALTER ROLE gstUsrRole DROP MEMBER GandalfUser;
END
DROP ROLE IF EXISTS gstUsrRole;
DROP USER IF EXISTS GandalfUser;
DELETE FROM dbo.Friend WHERE LastName IN ('Doe')  

--Create some users
CREATE USER GandalfUser WITHOUT LOGIN;

--Create a role for common users
CREATE ROLE gstUsrRole;

--SELECT only rights, nothing can be damaged
GRANT SELECT ON dbo.Friend to gstUsrRole;

ALTER ROLE gstUsrRole ADD MEMBER GandalfUser;

--Impersonate the users
EXECUTE AS USER = 'GandalfUser'; 

--This works
SELECT TOP 5 * FROM dbo.Friend;

--But not this
BEGIN TRY
    INSERT INTO dbo.Friend (FirstName, LastName, Email, Birthday, AddressId)
    VALUES ('Mary', 'Doe', NULL, NULL, NULL);
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--Nothing added
SELECT * FROM dbo.Friend WHERE LastName IN ('Doe')  

--end the impersonation session
REVERT;

--House cleaning
-- remove roles
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'gstUsrRole' AND type = 'R')
BEGIN
    ALTER ROLE gstUsrRole DROP MEMBER GandalfUser;
END
DROP ROLE IF EXISTS gstUsrRole;
DROP USER IF EXISTS GandalfUser;
