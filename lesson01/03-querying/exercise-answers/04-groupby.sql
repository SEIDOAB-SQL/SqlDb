USE music;
GO

-- Exercise 9: GROUP BY – count albums per music group
SELECT MusicGroupId, COUNT(*) AS NrAlbums
FROM dbo.Album
GROUP BY MusicGroupId;
GO
