Use Friends;
GO

--Let's find a friend that has pets and quotes
DECLARE @Friend  uniqueidentifier = (SELECT TOP 1 f.FriendId
    FROM dbo.friend f 
    INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
    INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
    INNER JOIN dbo.FriendQuote fq ON f.FriendId = fq.FriendId
    INNER JOIN dbo.Quote q ON fq.QuoteId = q.QuoteId)


--Let's remove a friend in the table Friend
--Note that SQL Server will not allow us to delete the friend because there are related records in the Pet 
--as well as there are related records in the FriendQuote table
DELETE dbo.Friend
WHERE FriendId = @Friend;
