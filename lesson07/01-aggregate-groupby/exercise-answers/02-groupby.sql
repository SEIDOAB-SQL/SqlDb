USE friends;
GO

-- Exercise 1: Number of pets per animal kind
SELECT AnimalKind, COUNT(*) AS PetCount
FROM dbo.Pet
GROUP BY AnimalKind
ORDER BY 2 DESC;

-- Exercise 2: Number of pets per friend (with full name)
SELECT f.FriendId,
    CONCAT_WS(' ', f.FirstName, f.LastName) AS FullName,
    COUNT(*) AS PetCount
FROM dbo.Friend f
    INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
GROUP BY f.FriendId, CONCAT_WS(' ', f.FirstName, f.LastName)
ORDER BY 3 DESC;

-- Exercise 3 Query 1: Number of friends born per year
SELECT YEAR(Birthday) AS BirthYear, COUNT(*) AS FriendCount
FROM dbo.Friend
GROUP BY YEAR(Birthday)
ORDER BY 1 ASC;

-- Exercise 3 Query 2: Number of friends born per year and month
SELECT YEAR(Birthday) AS BirthYear, MONTH(Birthday) AS BirthMonth, COUNT(*) AS FriendCount
FROM dbo.Friend
GROUP BY YEAR(Birthday), MONTH(Birthday)
ORDER BY 1, 2 ASC;
