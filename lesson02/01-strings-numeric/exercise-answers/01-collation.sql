USE friends;
GO

-- ============================================================
-- Exercise 1 – Discover server and database collation
-- ============================================================

-- Method 1a: SERVERPROPERTY
SELECT CONVERT(varchar(256), SERVERPROPERTY('collation')) AS ServerCollation;
GO

-- Method 1b: sp_helpsort (describes the sort order in plain text)
EXECUTE sp_helpsort;
GO

-- Method 2a: sys.databases
SELECT name, collation_name
FROM sys.databases
WHERE name = 'friends';
GO

-- Method 2b: DATABASEPROPERTYEX
SELECT CONVERT(varchar(256), DATABASEPROPERTYEX('friends', 'collation')) AS DatabaseCollation;
GO

-- ============================================================
-- Exercise 2 – Inspect column-level collations
-- ============================================================

SELECT
    t.name AS TableName,
    c.name AS ColumnName,
    c.collation_name AS CollationName
FROM sys.columns c
INNER JOIN sys.tables t ON c.object_id = t.object_id
WHERE c.collation_name IS NOT NULL
ORDER BY t.name, c.name;
GO

-- ============================================================
-- Exercise 3 – Case-sensitive vs case-insensitive search
-- ============================================================

-- Case-SENSITIVE: 'wanda' does NOT match stored value 'Wanda' → 0 rows
SELECT PetId, Name, AnimalKind
FROM dbo.Pet
WHERE Name = 'wanda' COLLATE Latin1_General_CS_AS;
GO

-- Case-INSENSITIVE: 'wanda' matches 'Wanda' → 1 row (the fish)
SELECT PetId, Name, AnimalKind
FROM dbo.Pet
WHERE Name = 'wanda' COLLATE Latin1_General_CI_AS;
GO
