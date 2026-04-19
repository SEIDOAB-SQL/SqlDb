USE friends;
GO

--UPDATE Triggers

--INSTEAD OF trigger example
CREATE OR ALTER TRIGGER trInsteadUpdateFriends
ON [dbo].[tmpFriends] INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    --inserted is a temporary in-memory table managed by SQL Server that keeps info about the row to be inserted
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM inserted;
    
    PRINT 'About to update ' + CAST (@Count AS NVARCHAR) + ' friends';

    UPDATE t
        SET FirstName = i.FirstName,
            LastName = i.LastName,
            Email = i.Email,
            Birthday = i.BirthDay,
            AddressId = i.AddressId,
            Modified = SYSDATETIME()
    FROM [dbo].[tmpFriends] t
    INNER JOIN inserted i ON t.FriendId = i.FriendId

   PRINT 'Updated ' + CAST (@@RowCount AS NVARCHAR) + ' friends';

END
GO

--AFTER trigger example
CREATE OR ALTER TRIGGER trAfterUpdateFriends
ON [dbo].[tmpFriends] AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM inserted;
 
    PRINT CAST (@Count AS NVARCHAR) + ' friends updated';
END
GO

--Let's update some values
UPDATE [dbo].[tmpFriends]
SET Firstname = 'Hairy'
WHERE FirstName = 'Harry' AND LastName = 'Potter';

SELECT * FROM [dbo].[tmpFriends] WHERE FirstName LIKE 'Ha%' AND LastName = 'Potter';


--List all triggers
SELECT  name, object_id, schema_id, parent_object_id, type_desc, create_date, modify_date, is_published  
FROM sys.objects  
WHERE type = 'TR';


--Cleanup
--When working with triggers is is important to ensure they work properly before moving to actual tables and actual data.
--Create a table for experiement, unfortunatly #temp tables does not work with trigger. 

--housekeeping
DROP TRIGGER IF EXISTS trInsteadInsertFriends;
DROP TRIGGER IF EXISTS trAfterInsertFriends;
DROP TRIGGER IF EXISTS trInsteadDeleteFriends;
DROP TRIGGER IF EXISTS trAfterDeleteFriends;
DROP TRIGGER IF EXISTS trInsteadUpdateFriends;
DROP TRIGGER IF EXISTS trAfterUpdateFriends;


DROP TABLE IF EXISTS [dbo].[tmpFriends];