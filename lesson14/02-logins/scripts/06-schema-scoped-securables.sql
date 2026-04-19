USE [friends];
GO

--House cleaning
DROP USER IF EXISTS PeregrinUser;

--I am in friends, but as sa - system administrator
CREATE USER PeregrinUser WITHOUT LOGIN;

--Give PeregrinUser some rights 
GRANT SELECT, INSERT ON dbo.Friend TO PeregrinUser;

--Starting the impersonation session as PeregrinUser
EXECUTE AS USER = 'PeregrinUser';
------------------------------------------------
--From here on, I am PeregrinUser

--This works
SELECT TOP 5 * FROM dbo.Friend;
INSERT INTO dbo.Friend (FirstName, LastName, Email, Birthday, AddressId)
VALUES ('Mary', 'Doe', NULL, NULL, NULL);

SELECT * FROM dbo.Friend WHERE LastName IN ('Doe')  

--But not this
BEGIN TRY
    UPDATE dbo.Friend
    SET FirstName = 'Ann'
    WHERE LastName IN ('Doe')
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--Ending the impersonation session
REVERT;
-------------------------------------------------
--From here on, I am system Admin again (logged in as sa)

--House cleaning
DROP USER IF EXISTS PeregrinUser;
