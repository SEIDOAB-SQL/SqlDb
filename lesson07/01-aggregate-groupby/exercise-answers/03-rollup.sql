USE friends;
GO

-- Exercise 1: Number of friends per country and city with ROLLUP
SELECT
    COALESCE(a.Country, 'All countries') AS Country,
    COALESCE(a.City, 'All cities') AS City,
    COUNT(*) AS NrFriends
FROM dbo.Friend f
    INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
GROUP BY a.Country, a.City WITH ROLLUP
ORDER BY 1, 2 ASC;

-- Exercise 2: Number of pets per country and city with ROLLUP
SELECT
    COALESCE(a.Country, 'All countries') AS Country,
    COALESCE(a.City, 'All cities') AS City,
    COUNT(*) AS NrPets
FROM dbo.Pet p
    INNER JOIN dbo.Friend f ON p.OwnerId = f.FriendId
    INNER JOIN dbo.Address a ON f.AddressId = a.AddressId
GROUP BY a.Country, a.City WITH ROLLUP
ORDER BY 1, 2 ASC;
