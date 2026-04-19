# Lesson 06 – Exercises: Indexes

> **Database:** `music`
>
> | Table | Key columns |
> |---|---|
> | `Artist` | `ArtistId`, `FirstName`, `LastName`, `BirthDay` |
> | `MusicGroup` | `MusicGroupId`, `Name`, `EstablishedYear`, `Genre` |
> | `Album` | `AlbumId`, `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` |
> | `ArtistMusicGroup` | `ArtistId`, `MusicGroupId` |

---

## Exercise 1 – Create, inspect, and drop a single-column index

**Task:**  
1. Create a non-clustered index named `IX_Artist_LastName` on the `Artist` table's `LastName` column.  
2. Use `EXEC sp_helpindex` to list all indexes on `dbo.Artist` and confirm the new index appears.  
3. Query `sys.indexes` filtered to `dbo.Artist` to see the full index metadata.  
4. Drop the index when done.

**Hint:**  
`CREATE INDEX <name> ON <table> (<column>)` — no `UNIQUE` keyword for a plain non-clustered index. Use `OBJECT_ID('dbo.Artist')` in the `WHERE` clause of `sys.indexes`.

**Expected outcome:**  
`sp_helpindex` lists `IX_Artist_LastName` as a non-clustered, non-unique index on `LastName`. After `DROP INDEX`, it no longer appears.

**Answer:** [01-indexes.sql](../exercise-answers/01-indexes.sql)

---

## Exercise 2 – Unique multi-column index and a query-optimisation index

**Task:**  
1. Create a **unique** index named `UQ_Album_Name_MusicGroup` on `dbo.Album` across **both** `Name` and `MusicGroupId`. This prevents the same album title being entered twice for the same group.  
2. Create a regular (non-unique) index named `IX_Album_ReleaseYear_CopiesSold` on `dbo.Album` across `ReleaseYear` and `CopiesSold` (in that order). This supports range and sort queries by release year.  
3. Use `EXEC sp_helpindex` on `dbo.Album` to confirm both indexes are listed.  
4. Query `sys.indexes` for `dbo.Album` to inspect the `is_unique` flag and index type for each.  
5. Drop both indexes.

**Hint:**  
Add the `UNIQUE` keyword between `CREATE` and `INDEX` for the first index. Both `sp_helpindex` and `sys.indexes` work the same way as in Exercise 1 — just change the table name.

**Expected outcome:**  
`sp_helpindex` shows `UQ_Album_Name_MusicGroup` marked as unique and `IX_Album_ReleaseYear_CopiesSold` as non-unique. The `is_unique` column in `sys.indexes` is `1` for the first and `0` for the second. After both `DROP INDEX` statements, neither appears.

**Answer:** [01-indexes.sql](../exercise-answers/01-indexes.sql)
