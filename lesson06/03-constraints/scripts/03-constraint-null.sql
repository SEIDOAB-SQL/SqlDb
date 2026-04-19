Use Friends;
GO

--Let look at friends that have pets and quotes
SELECT f.FriendId, f.FirstName, f.LastName, p.PetId, p.Name, p.OwnerId, q.QuoteId
FROM dbo.friend f 
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
INNER JOIN dbo.FriendQuote fq ON f.FriendId = fq.FriendId
INNER JOIN dbo.Quote q ON fq.QuoteId = q.QuoteId


DECLARE @Friend  uniqueidentifier = (SELECT TOP 1 f.FriendId
    FROM dbo.friend f 
    INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
    INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
    INNER JOIN dbo.FriendQuote fq ON f.FriendId = fq.FriendId
    INNER JOIN dbo.Quote q ON fq.QuoteId = q.QuoteId)


SELECT PetId FROM Pet WHERE OwnerId = @Friend;
SELECT QuoteId FROM FriendQuote WHERE FriendId = @Friend;

--Let's remove a friend in the table Friend
DELETE dbo.Friend
WHERE FriendId = @Friend;

--Note that the Friend is deleted but the Pet is not deleted, instead the OwnerId is set to NULL
SELECT * FROM dbo.Friend WHERE FriendId = @Friend;
SELECT * FROM dbo.Pet WHERE OwnerId = @Friend;
SELECT * FROM dbo.FriendQuote WHERE FriendId = @Friend;


SELECT * FROM dbo.Pet WHERE OwnerId IS NULL;
