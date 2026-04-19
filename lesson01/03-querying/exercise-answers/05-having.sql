USE music;
GO

-- Exercise 12: HAVING – music groups with more than one album
SELECT MusicGroupId, COUNT(*) AS NrAlbums
FROM dbo.Album
GROUP BY MusicGroupId
HAVING COUNT(*) > 1;
GO

-- Exercise 13: ORDER BY on grouped result – genres by number of music groups, highest first
SELECT Genre, COUNT(*) AS NrGroups
FROM dbo.MusicGroup
GROUP BY Genre
ORDER BY NrGroups DESC;
GO
