USE music;
GO

-- Exercise 7: ORDER BY – all albums from oldest to newest
SELECT Name, ReleaseYear
FROM dbo.Album
ORDER BY ReleaseYear ASC;
GO

-- Exercise 8: ORDER BY – top 5 best-selling albums, highest first
SELECT TOP 5 Name, CopiesSold
FROM dbo.Album
ORDER BY CopiesSold DESC;
GO
