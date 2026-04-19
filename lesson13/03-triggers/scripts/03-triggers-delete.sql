USE friends;
GO

--DELETE Triggers

--INSTEAD OF trigger example
CREATE OR ALTER TRIGGER trInsteadDeleteFriends
ON [dbo].[tmpFriends] INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    --deleted is a temporary in-memory table managed by SQL Server that keeps info about the row to be deleted
    --I use this to deleteion of anyone called Harry Potter
    DELETE FROM [dbo].[tmpFriends] 
    WHERE [dbo].[tmpFriends].FriendId IN (SELECT FriendId From deleted) 
        AND NOT ([dbo].[tmpFriends].FirstName = 'Harry' AND [dbo].[tmpFriends].LastName = 'Potter') ;
END
GO

--AFTER trigger example
CREATE OR ALTER TRIGGER trAfterDeleteFriends
ON [dbo].[tmpFriends] AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    --Deletion is done.
    SELECT a.City, COUNT(d.FriendId) AS [Count]
    FROM deleted d
    INNER JOIN dbo.Address a ON d.AddressId = a.AddressId
    GROUP BY a.City
    ORDER BY 2;

END
GO


--Let's delete some rows
SELECT COUNT(*) FROM [dbo].[tmpFriends] f
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId 
WHERE a.City = 'Stockholm'

--Let's delete some rows in a specific city
DELETE f FROM [dbo].[tmpFriends] f
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId 
WHERE a.City = 'Stockholm'

SELECT COUNT(*) FROM [dbo].[tmpFriends] f
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId 
WHERE a.City = 'Stockholm'


--List all triggers
SELECT  name, object_id, schema_id, parent_object_id, type_desc, create_date, modify_date, is_published  
FROM sys.objects  
WHERE type = 'TR';   