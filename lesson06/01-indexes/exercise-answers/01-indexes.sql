USE music;
GO

-- ============================================================
-- Exercise 1 – Single-column index on Artist.LastName
-- ============================================================

-- Step 1 – Create the index
CREATE INDEX IX_Artist_LastName ON dbo.Artist (LastName);

-- Step 2 – List all indexes on dbo.Artist
EXEC sp_helpindex 'dbo.Artist';

-- Step 3 – Full index metadata from the catalogue
SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('dbo.Artist');

-- Step 4 – Drop the index
DROP INDEX IX_Artist_LastName ON dbo.Artist;
GO

-- ============================================================
-- Exercise 2 – Unique multi-column index + query-optimisation index on Album
-- ============================================================

-- Step 1 – Unique index: prevents duplicate album name per music group
CREATE UNIQUE INDEX UQ_Album_Name_MusicGroup
    ON dbo.Album (Name, MusicGroupId);

-- Step 2 – Non-unique index: supports range and sort queries by release year
CREATE INDEX IX_Album_ReleaseYear_CopiesSold
    ON dbo.Album (ReleaseYear, CopiesSold);

-- Step 3 – List all indexes on dbo.Album
EXEC sp_helpindex 'dbo.Album';

-- Step 4 – Inspect is_unique flag and index type
SELECT name, type_desc, is_unique
FROM sys.indexes
WHERE object_id = OBJECT_ID('dbo.Album');

-- Step 5 – Drop both indexes
DROP INDEX UQ_Album_Name_MusicGroup        ON dbo.Album;
DROP INDEX IX_Album_ReleaseYear_CopiesSold ON dbo.Album;
GO
