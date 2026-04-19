USE friends;
GO

--Question is: List all the cities in one of the contries with most pets, in a single SQL

--Break down the challange

-- 1. Find one Country with most Pets
SELECT TOP 1 a.Country, COUNT(p.PetId) [Nr of Pets] FROM dbo.Friend f
INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
GROUP BY a.Country
ORDER BY 2 DESC;

-- 2. Isolate Country only, by using step1 as a subquery
SELECT mpc.Country FROM (SELECT TOP 1 a.Country, COUNT(p.PetId) [Nr of Pets] FROM dbo.Friend f
INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
GROUP BY a.Country
ORDER BY 2 DESC) mpc;

-- 3. Test the main query
SELECT DISTINCT Country, City FROM dbo.Address
WHERE Country = 'Sweden';

-- 4. Now combine combine step 2 and 3 into one single SQL query

--Question is: List all the cities in one of the contries with most pets, in a single SQL
SELECT DISTINCT Country, City FROM dbo.Address
WHERE Country = (
    SELECT mpc.Country FROM (SELECT TOP 1 a.Country, COUNT(p.PetId) [Nr of Pets] FROM dbo.Friend f
    INNER JOIN dbo.Pet p ON f.FriendId = p.OwnerId
    INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
    GROUP BY a.Country
    ORDER BY 2 DESC) mpc
        );

