USE music;
GO

-- Exercise 1: ALL Operator

-- Query 1: Albums that outsold every pre-2000 album
SELECT Name, ReleaseYear, CopiesSold
FROM dbo.Album
WHERE CopiesSold >ALL (
    SELECT CopiesSold FROM dbo.Album
    WHERE ReleaseYear < 2000)
ORDER BY CopiesSold DESC;

-- Query 2: Albums that sold less than every post-2010 album
SELECT Name, ReleaseYear, CopiesSold
FROM dbo.Album
WHERE CopiesSold <ALL (
    SELECT CopiesSold FROM dbo.Album
    WHERE ReleaseYear > 2010)
ORDER BY CopiesSold ASC;

-- Exercise 2: ANY Operator

-- Helper query: total copies sold per Jazz and Blues genre (verify first)
-- SELECT mg.Genre, SUM(a.CopiesSold) AS TotalCopies
-- FROM dbo.Album a
--     INNER JOIN dbo.MusicGroup mg ON a.MusicGroupId = mg.MusicGroupId
-- WHERE mg.Genre IN ('Jazz', 'Blues')
-- GROUP BY mg.Genre;

-- Query 1: Music groups with total copies sold greater than any Jazz or Blues genre total
SELECT mg.MusicGroupId, mg.Name, SUM(a.CopiesSold) AS TotalCopiesSold
FROM dbo.MusicGroup mg
    INNER JOIN dbo.Album a ON mg.MusicGroupId = a.MusicGroupId
GROUP BY mg.MusicGroupId, mg.Name
HAVING SUM(a.CopiesSold) >ANY (
    SELECT SUM(a2.CopiesSold)
    FROM dbo.Album a2
        INNER JOIN dbo.MusicGroup mg2 ON a2.MusicGroupId = mg2.MusicGroupId
    WHERE mg2.Genre IN ('Jazz', 'Blues')
    GROUP BY mg2.Genre)
ORDER BY TotalCopiesSold DESC;

-- Query 2: Music groups with total copies sold less than any Jazz or Blues genre total
SELECT mg.MusicGroupId, mg.Name, SUM(a.CopiesSold) AS TotalCopiesSold
FROM dbo.MusicGroup mg
    INNER JOIN dbo.Album a ON mg.MusicGroupId = a.MusicGroupId
GROUP BY mg.MusicGroupId, mg.Name
HAVING SUM(a.CopiesSold) <ANY (
    SELECT SUM(a2.CopiesSold)
    FROM dbo.Album a2
        INNER JOIN dbo.MusicGroup mg2 ON a2.MusicGroupId = mg2.MusicGroupId
    WHERE mg2.Genre IN ('Jazz', 'Blues')
    GROUP BY mg2.Genre)
ORDER BY TotalCopiesSold ASC;

-- Exercise 3: EXISTS Operator

-- Query 1: Music groups with at least one album selling more than 1,000,000 copies
SELECT mg.Name, mg.Genre
FROM dbo.MusicGroup mg
WHERE EXISTS (
    SELECT 1 FROM dbo.Album a
    WHERE a.MusicGroupId = mg.MusicGroupId
      AND a.CopiesSold > 1000000);

-- Query 2: Music groups with no album selling more than 1,000,000 copies
SELECT mg.Name, mg.Genre
FROM dbo.MusicGroup mg
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Album a
    WHERE a.MusicGroupId = mg.MusicGroupId
      AND a.CopiesSold > 1000000);
