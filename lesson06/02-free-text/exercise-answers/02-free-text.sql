USE music;
GO

-- ============================================================
-- Exercise 1 – Check FTS installation and inspect system catalog views
-- ============================================================

-- Confirm Full-Text Search is installed (1 = installed)
SELECT FULLTEXTSERVICEPROPERTY('IsFullTextInstalled');

-- Inspect existing full-text objects (all empty at this point)
SELECT * FROM sys.fulltext_catalogs;
SELECT * FROM sys.fulltext_indexes;
SELECT * FROM sys.fulltext_index_columns;
GO

-- ============================================================
-- Exercise 2 – Create full-text catalog and index on Album
-- ============================================================

-- Step 1 – Full-text catalog
CREATE FULLTEXT CATALOG musicFtCatalog AS DEFAULT;

-- Step 2 – Unique index required as the key index for FTS
CREATE UNIQUE INDEX Album_FTS_idx ON dbo.Album(AlbumId);

-- Step 3 – Full-text index on Album.Name
CREATE FULLTEXT INDEX ON dbo.Album
(
    [Name] Language 1033
)
KEY INDEX Album_FTS_idx ON musicFtCatalog;
GO

-- Step 4 – Confirm the objects now exist
SELECT * FROM sys.fulltext_catalogs;
SELECT * FROM sys.fulltext_indexes;
SELECT * FROM sys.fulltext_index_columns;

-- Step 5 – Inspect tokenised keywords in the index
-- (Allow a few seconds for the index to populate before running)
SELECT * FROM sys.dm_fts_index_keywords(DB_ID('music'), OBJECT_ID('dbo.Album'));
GO

-- ============================================================
-- Exercise 3 – CONTAINS queries on Album.Name
-- ============================================================

-- 1. Search all FTS columns for the word 'Black'
SELECT * FROM dbo.Album WHERE CONTAINS(*, 'Black');

-- 2. Search only the Name column for 'Black'
SELECT * FROM dbo.Album WHERE CONTAINS(Name, 'Black');

-- 3. NEAR – albums where 'Kind' appears close to 'Blue'
SELECT * FROM dbo.Album WHERE CONTAINS(Name, 'Kind NEAR Blue');

-- 4. AND NOT – albums containing 'Black' but not 'Back'
SELECT * FROM dbo.Album WHERE CONTAINS(Name, 'Black AND NOT Back');

-- 5. Exact phrase search
SELECT * FROM dbo.Album WHERE CONTAINS(Name, '"Led Zeppelin"');
GO

-- ============================================================
-- Exercise 4 – FREETEXT queries on Album.Name
-- ============================================================

-- 1. Linguistic search for 'black' (stemming may match variants)
SELECT * FROM dbo.Album WHERE FREETEXT(*, 'black');

-- 2. Any of the words 'lightning', 'hell', 'heaven'
SELECT * FROM dbo.Album WHERE FREETEXT(*, 'lightning hell heaven');
GO

-- ============================================================
-- Cleanup – drop FTS objects created in Exercise 2
-- ============================================================

DROP FULLTEXT INDEX ON dbo.Album;
DROP FULLTEXT CATALOG musicFtCatalog;
DROP INDEX Album_FTS_idx ON dbo.Album;
GO
