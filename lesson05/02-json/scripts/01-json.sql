USE friends;
GO

--Get full detail of a friend in JSON
SELECT f.FriendId , f.FirstName , f.LastName, 
    a.Country AS Country, CONCAT_WS(' ', p.Name, 'the happy', p.AnimalKind) AS Pet
FROM dbo.friend f
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
FOR JSON PATH


--you can store it in an json file using azure data studio. 
--I modified so it can be opened in Excel
--   1. Click on the result so it opens up in a new Azure tab
--   2. save the tab as a json file, friends1.json. Make sure you do save as.. and select JSON format

