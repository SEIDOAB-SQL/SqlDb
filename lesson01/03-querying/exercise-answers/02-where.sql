USE music;
GO

-- Exercise 4: WHERE – Rock music groups with their established year
SELECT Name, EstablishedYear
FROM dbo.MusicGroup
WHERE Genre = 'Rock';
GO

-- Exercise 5: WHERE – Albums that sold more than 10 million copies
SELECT Name, CopiesSold
FROM dbo.Album
WHERE CopiesSold > 10000000;
GO

-- Exercise 6: WHERE – Artists with no known birthday
SELECT FirstName, LastName
FROM dbo.Artist
WHERE BirthDay IS NULL;
GO
