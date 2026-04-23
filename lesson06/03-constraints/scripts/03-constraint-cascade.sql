Use Friends;
GO

--Let's find a friend that has pets and quotes
DECLARE @Friend  uniqueidentifier = (SELECT TOP 1 f.FriendId
    FROM dbo.friend f 
    INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
    INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
    INNER JOIN dbo.FriendQuote fq ON f.FriendId = fq.FriendId
    INNER JOIN dbo.Quote q ON fq.QuoteId = q.QuoteId)


SELECT * FROM Pet WHERE OwnerId = @Friend;
SELECT * FROM FriendQuote WHERE FriendId = @Friend;

--Let's remove a friend in the table Friend
--Now it will work
DELETE dbo.Friend
WHERE FriendId = @Friend;

--Note that the Friend is deleted as well as the pets and quotes related to that friend. 
--This is because of the ON DELETE CASCADE constraint defined on the foreign keys in the Pet and FriendQuote tables.
SELECT * FROM dbo.Friend WHERE FriendId = @Friend;
SELECT * FROM dbo.Pet WHERE OwnerId = @Friend;
SELECT * FROM dbo.FriendQuote WHERE FriendId = @Friend;

