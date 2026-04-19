USE music;
GO

-- Exercise 1: Scalar subquery

-- Query 1: Album(s) with the highest copies sold
SELECT Name, CopiesSold
FROM dbo.Album
WHERE CopiesSold = (SELECT MAX(CopiesSold) FROM dbo.Album);

-- Query 2: All albums except the best-selling one
SELECT Name, CopiesSold
FROM dbo.Album
WHERE CopiesSold < (SELECT MAX(CopiesSold) FROM dbo.Album)
ORDER BY CopiesSold DESC;

-- Exercise 2: IN subquery — albums by Rock or Blues groups

-- Inner query on its own (verify first)
-- SELECT MusicGroupId FROM dbo.MusicGroup WHERE Genre IN ('Rock', 'Blues');

SELECT Name, ReleaseYear
FROM dbo.Album
WHERE MusicGroupId IN (SELECT MusicGroupId FROM dbo.MusicGroup WHERE Genre IN ('Rock', 'Blues'))
ORDER BY ReleaseYear ASC;

-- Exercise 3: IN / NOT IN with NULL awareness

-- Query 1: Albums released in a year when at least one artist was born
SELECT Name, ReleaseYear
FROM dbo.Album
WHERE ReleaseYear IN (SELECT DISTINCT YEAR(BirthDay) FROM dbo.Artist);

-- Query 2: Albums NOT released in a birth year — subquery includes NULLs (likely returns no rows)
SELECT Name, ReleaseYear
FROM dbo.Album
WHERE ReleaseYear NOT IN (SELECT DISTINCT YEAR(BirthDay) FROM dbo.Artist);

-- Query 3: Same as Query 2 but NULL birth years excluded — returns correct result
SELECT Name, ReleaseYear
FROM dbo.Album
WHERE ReleaseYear NOT IN (
    SELECT DISTINCT YEAR(BirthDay) FROM dbo.Artist
    WHERE BirthDay IS NOT NULL);

-- Exercise 4: Nested subquery — music groups in the genre with the highest total copies sold

-- Step 1: Total copies sold per genre
SELECT mg.Genre, SUM(a.CopiesSold) AS TotalCopies
FROM dbo.Album a INNER JOIN dbo.MusicGroup mg ON a.MusicGroupId = mg.MusicGroupId
GROUP BY mg.Genre;

-- Step 2: Top genre only
SELECT TOP 1 mg.Genre, SUM(a.CopiesSold) AS TotalCopies
FROM dbo.Album a INNER JOIN dbo.MusicGroup mg ON a.MusicGroupId = mg.MusicGroupId
GROUP BY mg.Genre
ORDER BY 2 DESC;

-- Final query: music groups belonging to the top genre
SELECT Name, EstablishedYear
FROM dbo.MusicGroup
WHERE Genre = (
    SELECT tg.Genre FROM (
        SELECT TOP 1 mg.Genre, SUM(a.CopiesSold) AS TotalCopies
        FROM dbo.Album a
            INNER JOIN dbo.MusicGroup mg ON a.MusicGroupId = mg.MusicGroupId
        GROUP BY mg.Genre
        ORDER BY 2 DESC
    ) tg
)
ORDER BY EstablishedYear ASC;
