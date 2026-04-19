USE friends;
GO

--Add a Best Friend column to the Friends table
ALTER TABLE dbo.Friend 
ADD BestFriendId uniqueidentifier NULL;
GO

--set a couple of Best Friends
UPDATE dbo.Friend
SET BestFriendId = (SELECT FriendId FROM dbo.Friend WHERE FirstName = 'Neville' AND LastName = 'Longbottom')
WHERE FirstName = 'Luna' AND LastName = 'Weasley';

UPDATE dbo.Friend
SET BestFriendId = (SELECT FriendId FROM dbo.Friend WHERE FirstName = 'Luna' AND LastName = 'Weasley')
WHERE FirstName = 'Neville' AND LastName = 'Longbottom';

--use a self join to get Best friend details
SELECT CONCAT_WS(' ', f.FirstName, f.LastName, 'is best friend with', bf.FirstName, bf.LastName)
FROM dbo.friend f 
INNER JOIN dbo.friend bf
ON f.BestFriendId = bf.FriendId;

--remove the BestFriend column
ALTER TABLE dbo.Friend 
DROP COLUMN BestFriendId;
