USE music;
GO

-- ============================================================
-- Exercise 1 – FOR XML AUTO
-- ============================================================

-- Query result directly as XML AUTO
SELECT *
FROM dbo.MusicGroup MusicGroup
INNER JOIN dbo.Album Album ON MusicGroup.MusicGroupId = Album.MusicGroupId
FOR XML AUTO;

-- Store in an XML variable and display
DECLARE @musicXML XML;

SET @musicXML = (
    SELECT *
    FROM dbo.MusicGroup MusicGroup
    INNER JOIN dbo.Album Album ON MusicGroup.MusicGroupId = Album.MusicGroupId
    FOR XML AUTO
);

SELECT @musicXML;
GO

-- ============================================================
-- Exercise 2 – FOR XML PATH
-- ============================================================

SELECT
    mg.MusicGroupId         "@MusicGroupId",
    mg.Name                 "Name",
    mg.Genre                "Genre",
    mg.EstablishedYear      "EstablishedYear",
    CONCAT(al.Name, ' (', al.ReleaseYear, ')') "Album"
FROM dbo.MusicGroup AS mg
INNER JOIN dbo.Album AS al ON mg.MusicGroupId = al.MusicGroupId
FOR XML PATH('MusicGroup');
GO
