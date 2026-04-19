USE friends;
GO

DECLARE @aPet NVARCHAR(200)

--multiple rows are returned so @aPet will be assigned last row.
SELECT @aPET = CONCAT_WS(' ', p.Name, 'the lazy', p.AnimalKind, 'is owned by', f.FirstName, f.LastName)
FROM dbo.Pet AS p 
    INNER JOIN dbo.Friend AS f ON p.OwnerId = f.FriendId;

SELECT @aPet;
--PRINT is shown in tab Messages
PRINT @aPet;


DECLARE @Harry    uniqueidentifier = (SELECT TOP 1 FriendId FROM Friend WHERE FirstName = 'Harry' AND LastName = 'Took');

SELECT @aPET = CONCAT_WS(' ', p.Name, 'the lazy', p.AnimalKind, 'is owned by', f.FirstName, f.LastName)
FROM dbo.Pet AS p 
    INNER JOIN dbo.Friend AS f ON p.OwnerId = f.FriendId
WHERE p.OwnerId = @Harry;

SELECT @aPet;
PRINT @aPet;

