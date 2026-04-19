USE music;
GO

-- Exercise 1: Basic SELECT – all columns from MusicGroup
SELECT * FROM dbo.MusicGroup;
GO

-- Exercise 2: Selecting specific columns – Name and Genre only
SELECT Name, Genre FROM dbo.MusicGroup;
GO

-- Exercise 3: DISTINCT genres, sorted alphabetically
SELECT DISTINCT Genre
FROM dbo.MusicGroup
ORDER BY Genre ASC;
GO
