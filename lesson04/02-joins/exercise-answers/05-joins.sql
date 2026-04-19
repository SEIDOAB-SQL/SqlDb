USE music;
GO

-- ============================================================
-- Exercise 1 – CROSS JOIN
-- ============================================================

-- Build #Genres from the MusicGroup table
SELECT DISTINCT Genre
INTO #Genres
FROM dbo.MusicGroup;

-- Build #Decades manually
SELECT '1940s' AS Decade INTO #Decades
UNION ALL SELECT '1950s'
UNION ALL SELECT '1960s'
UNION ALL SELECT '1970s'
UNION ALL SELECT '1980s'
UNION ALL SELECT '1990s';

-- Cross join to produce every genre–decade combination
SELECT CONCAT(g.Genre, ' in the ', d.Decade) AS Combination
FROM #Genres AS g
CROSS JOIN #Decades AS d
ORDER BY Combination;

DROP TABLE #Genres;
DROP TABLE #Decades;
GO

-- ============================================================
-- Exercise 2 – INNER JOIN
-- ============================================================

SELECT
    a.FirstName,
    a.LastName,
    mg.Name  AS MusicGroupName,
    mg.Genre
FROM dbo.Artist AS a
INNER JOIN dbo.ArtistMusicGroup AS amg ON a.ArtistId     = amg.ArtistId
INNER JOIN dbo.MusicGroup       AS mg  ON amg.MusicGroupId = mg.MusicGroupId
ORDER BY mg.Genre, a.LastName;
GO

-- ============================================================
-- Exercise 3 – SELF JOIN
-- ============================================================

-- Add the InfluencedBy column
ALTER TABLE dbo.Artist
ADD InfluencedBy uniqueidentifier NULL;
GO

-- Set influences
UPDATE dbo.Artist
SET InfluencedBy = (SELECT ArtistId FROM dbo.Artist WHERE FirstName = 'B.B.' AND LastName = 'King')
WHERE FirstName = 'Angus' AND LastName = 'Young';

UPDATE dbo.Artist
SET InfluencedBy = (SELECT ArtistId FROM dbo.Artist WHERE FirstName = 'Ozzy' AND LastName = 'Osbourne')
WHERE FirstName = 'James' AND LastName = 'Hetfield';

-- Self join to display the influence relationships
SELECT CONCAT_WS(' ', a.FirstName, a.LastName, 'was influenced by', inf.FirstName, inf.LastName) AS Influence
FROM dbo.Artist AS a
INNER JOIN dbo.Artist AS inf ON a.InfluencedBy = inf.ArtistId;

-- Drop the column
ALTER TABLE dbo.Artist
DROP COLUMN InfluencedBy;
GO

-- ============================================================
-- Exercise 4 – LEFT OUTER JOIN
-- ============================================================

-- Insert a group with no albums
INSERT INTO dbo.MusicGroup (Name, EstablishedYear, Genre)
VALUES ('Pink Floyd', 1965, 'Rock');

-- All music groups, including those with no albums
SELECT
    mg.Name  AS MusicGroupName,
    mg.Genre,
    al.Name  AS AlbumName
FROM dbo.MusicGroup AS mg
LEFT OUTER JOIN dbo.Album AS al ON mg.MusicGroupId = al.MusicGroupId
ORDER BY mg.Name;

-- Clean up test row
DELETE FROM dbo.MusicGroup WHERE Name = 'Pink Floyd';
GO

-- ============================================================
-- Exercise 5 – RIGHT OUTER JOIN
-- ============================================================

-- Insert an orphan album (no music group)
INSERT INTO dbo.Album (Name, ReleaseYear, CopiesSold)
VALUES ('Unplugged', 1994, 8000000);

-- All albums, including those with no music group
SELECT
    mg.Name  AS MusicGroupName,
    mg.Genre,
    al.Name  AS AlbumName,
    al.ReleaseYear
FROM dbo.MusicGroup AS mg
RIGHT OUTER JOIN dbo.Album AS al ON mg.MusicGroupId = al.MusicGroupId
ORDER BY al.Name;

-- Clean up test row
DELETE FROM dbo.Album WHERE Name = 'Unplugged' AND MusicGroupId IS NULL;
GO

-- ============================================================
-- Exercise 6 – FULL OUTER JOIN
-- ============================================================

-- Insert an artist not linked to any group
INSERT INTO dbo.Artist (FirstName, LastName)
VALUES ('Elvis', 'Presley');

-- All artists and all group memberships — unmatched rows show NULL
SELECT
    a.FirstName,
    a.LastName,
    amg.MusicGroupId
FROM dbo.Artist AS a
FULL OUTER JOIN dbo.ArtistMusicGroup AS amg ON a.ArtistId = amg.ArtistId
ORDER BY a.LastName;

-- Clean up test row
DELETE FROM dbo.Artist WHERE FirstName = 'Elvis' AND LastName = 'Presley';
GO
