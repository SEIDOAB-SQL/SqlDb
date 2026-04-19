# Lesson 06 – Exercises: Full-Text Search

> **Database:** `music`
>
> | Table | Key columns |
> |---|---|
> | `Artist` | `ArtistId`, `FirstName`, `LastName`, `BirthDay` |
> | `MusicGroup` | `MusicGroupId`, `Name`, `EstablishedYear`, `Genre` |
> | `Album` | `AlbumId`, `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` |
> | `ArtistMusicGroup` | `ArtistId`, `MusicGroupId` |
>
> **Note:** Exercises 3 and 4 require the full-text index created in Exercise 2 to still be in place.

---

## Exercise 1 – Check FTS installation and inspect system catalog views

**Task:**  
1. Use `FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')` to confirm that Full-Text Search is installed on the server. A return value of `1` means it is installed.  
2. Query `sys.fulltext_catalogs`, `sys.fulltext_indexes`, and `sys.fulltext_index_columns` to list any existing full-text objects in the `music` database. At this point all three should be empty.

**Hint:**  
Switch to the `music` database first with `USE music; GO`. Each system view is a simple `SELECT * FROM sys.<view_name>`.

**Expected outcome:**  
`FULLTEXTSERVICEPROPERTY` returns `1`. All three system view queries return zero rows.

**Answer:** [02-free-text.sql](../exercise-answers/02-free-text.sql)

---

## Exercise 2 – Create a full-text catalog and index on `Album`

**Task:**  
1. Create a full-text catalog named `musicFtCatalog` as the default catalog.  
2. Create a unique index named `Album_FTS_idx` on `dbo.Album(AlbumId)`. This is required as the key index for the full-text index.  
3. Create a full-text index on `dbo.Album` covering the `Name` column with Language `1033` (English), referencing `Album_FTS_idx` and stored in `musicFtCatalog`.  
4. Re-query `sys.fulltext_catalogs`, `sys.fulltext_indexes`, and `sys.fulltext_index_columns` to confirm all three objects now appear.  
5. Use `sys.dm_fts_index_keywords(DB_ID('music'), OBJECT_ID('dbo.Album'))` to inspect the tokenised keywords in the index.

> **Do not drop the index yet** — it is needed for Exercises 3 and 4.  
> Cleanup SQL is provided at the bottom of the answer file.

**Hint:**  
The `CREATE FULLTEXT INDEX` syntax is: `CREATE FULLTEXT INDEX ON <table>(<column> Language <lcid>) KEY INDEX <unique_index_name> ON <catalog_name>;`

**Expected outcome:**  
Each system view returns one row. The DMV lists every indexed keyword token from every album title (e.g. `back`, `black`, `zeppelin`, `puppets`, etc.).

**Answer:** [02-free-text.sql](../exercise-answers/02-free-text.sql)

---

## Exercise 3 – `CONTAINS` queries on `Album.Name`

> Requires the full-text index from Exercise 2.

**Task:**  
Write the following five `CONTAINS`-based queries against `dbo.Album`:

1. Search **all** full-text columns for the word `'Black'` and return matching rows.  
2. Search only the `Name` column for the word `'Black'`.  
3. Use `NEAR` to find albums where `'Kind'` appears close to `'Blue'` in the `Name` column.  
4. Use `AND NOT` to find albums whose `Name` contains `'Black'` but **not** `'Back'`.  
5. Search for the exact phrase `'"Led Zeppelin"'` in the `Name` column.

**Hint:**  
- `CONTAINS(*, 'word')` searches all indexed columns; `CONTAINS(Name, 'word')` targets a single column.  
- Enclose phrases in double quotes inside the single-quoted string: `CONTAINS(Name, '"exact phrase"')`.  
- `AND NOT` excludes rows where the second term is present.

**Expected outcome:**  
1. & 2. Return `The Black Album` and `Back in Black`.  
3. Returns `Kind of Blue`.  
4. Returns only `The Black Album` (not `Back in Black`).  
5. Returns `Led Zeppelin IV`.

**Answer:** [02-free-text.sql](../exercise-answers/02-free-text.sql)

---

## Exercise 4 – `FREETEXT` queries on `Album.Name`

> Requires the full-text index from Exercise 2.

**Task:**  
Write the following two `FREETEXT`-based queries against `dbo.Album`:

1. Search all full-text columns for `'black'`. Observe that `FREETEXT` applies linguistic analysis (stemming), potentially returning more rows than a plain `CONTAINS` for the same term.  
2. Search all columns for any of the words `'lightning hell heaven'` to find albums related to any of those themes.

**Hint:**  
`FREETEXT(*,'word1 word2 word3')` returns rows where **any** of the provided words (or their linguistic variants) appear in an indexed column. It is less precise than `CONTAINS` but better for natural-language searches.

**Expected outcome:**  
1. Returns albums containing `black` or stemmed variants — at minimum `The Black Album` and `Back in Black`.  
2. Returns `Ride the Lightning`, `Highway to Hell`, and `Heaven and Hell`.

**Answer:** [02-free-text.sql](../exercise-answers/02-free-text.sql)
