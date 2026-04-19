# Lesson 04 – Exercises: Joins

Use the `music` database for all exercises.

The database has four tables:

| Table | Key columns |
|---|---|
| `Artist` | `ArtistId`, `FirstName`, `LastName`, `BirthDay` |
| `MusicGroup` | `MusicGroupId`, `Name`, `EstablishedYear`, `Genre` |
| `Album` | `AlbumId`, `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` |
| `ArtistMusicGroup` | `ArtistId`, `MusicGroupId` (join table) |

---

## Exercise 1 – CROSS JOIN

**Task:** Create two temporary tables:

1. `#Genres` — populated with the **distinct** `Genre` values from `MusicGroup`.
2. `#Decades` — populated manually with the following rows: `1940s`, `1950s`, `1960s`, `1970s`, `1980s`, `1990s`.

Use a `CROSS JOIN` between `#Genres` and `#Decades` to generate every possible genre–decade combination. Return a single column called `Combination` formatted as `'<Genre> in the <Decade>'` (e.g. `Rock in the 1970s`). Order alphabetically by the result. Drop both temporary tables when done.

**Hint:** Use `SELECT DISTINCT Genre INTO #Genres` and build `#Decades` with `SELECT … UNION ALL SELECT …` into a temp table. Use `CONCAT_WS` or `+` to format the combination column.

**Expected outcome:** 24 rows (4 genres × 6 decades), each showing a genre–decade pairing.

**Answer:** [05-joins.sql](../exercise-answers/05-joins.sql)

---

## Exercise 2 – INNER JOIN

**Task:** Write a query that lists every artist alongside the music group they belong to and that group's genre. Return `FirstName`, `LastName`, `MusicGroupName`, and `Genre`. Order by `Genre`, then `LastName`.

**Hint:** Join `Artist` → `ArtistMusicGroup` → `MusicGroup` using two `INNER JOIN`s. Alias `MusicGroup.Name` as `MusicGroupName`.

**Expected outcome:** One row per artist–group membership. Artists who are in no group will not appear.

**Answer:** [05-joins.sql](../exercise-answers/05-joins.sql)

---

## Exercise 3 – SELF JOIN

**Task:** Add a nullable `uniqueidentifier` column called `InfluencedBy` to the `Artist` table. Set the following influences:

- **Angus Young** was influenced by **B.B. King**
- **James Hetfield** was influenced by **Ozzy Osbourne**

Write a self-join query that returns a sentence for each artist who has an influence recorded, in the pattern:

> `<FirstName> <LastName> was influenced by <FirstName> <LastName>`

Finally, drop the `InfluencedBy` column.

**Hint:** Join `dbo.Artist AS a` to `dbo.Artist AS inf` on `a.InfluencedBy = inf.ArtistId`. Use subqueries in the `UPDATE` statements to look up `ArtistId` by name.

**Expected outcome:** Two rows — one for Angus Young and one for James Hetfield — each showing their influence.

**Answer:** [05-joins.sql](../exercise-answers/05-joins.sql)

---

## Exercise 4 – LEFT OUTER JOIN

**Task:** Write a query that returns **all music groups**, even those with no albums. Return `MusicGroup.Name` as `MusicGroupName`, `Genre`, and `Album.Name` as `AlbumName`. Where a group has no album, `AlbumName` should be `NULL`.

To make the NULL case visible, first insert a music group with no albums:

```sql
INSERT INTO dbo.MusicGroup (Name, EstablishedYear, Genre)
VALUES ('Pink Floyd', 1965, 'Rock');
```

After verifying your results, delete the test row.

**Hint:** `MusicGroup LEFT OUTER JOIN Album ON MusicGroup.MusicGroupId = Album.MusicGroupId`.

**Expected outcome:** All music groups appear. Pink Floyd (and any other group without albums) shows `NULL` in `AlbumName`.

**Answer:** [05-joins.sql](../exercise-answers/05-joins.sql)

---

## Exercise 5 – RIGHT OUTER JOIN

**Task:** To demonstrate a right outer join, first insert an orphan album (one with no music group):

```sql
INSERT INTO dbo.Album (Name, ReleaseYear, CopiesSold)
VALUES ('Unplugged', 1994, 8000000);
```

Write a query using `RIGHT OUTER JOIN` that returns **all albums**, even those not linked to any music group. Return `MusicGroup.Name` as `MusicGroupName`, `Genre`, `Album.Name` as `AlbumName`, and `ReleaseYear`. Where an album has no group, the group columns should be `NULL`.

After verifying your results, delete the orphan album.

**Hint:** `dbo.MusicGroup RIGHT OUTER JOIN dbo.Album ON MusicGroup.MusicGroupId = Album.MusicGroupId`.

**Expected outcome:** All albums appear. The orphan `Unplugged` album shows `NULL` in `MusicGroupName` and `Genre`.

**Answer:** [05-joins.sql](../exercise-answers/05-joins.sql)

---

## Exercise 6 – FULL OUTER JOIN

**Task:** Write a query using a `FULL OUTER JOIN` between `Artist` and `ArtistMusicGroup` that shows:

- All artists, including those not linked to any group.
- All `ArtistMusicGroup` entries, including any that reference a non-existent artist.

Return `FirstName`, `LastName`, and `MusicGroupId`. To make the unmatched artist visible, first insert an artist not linked to any group:

```sql
INSERT INTO dbo.Artist (FirstName, LastName)
VALUES ('Elvis', 'Presley');
```

After verifying your results, delete the test row.

**Hint:** `dbo.Artist FULL OUTER JOIN dbo.ArtistMusicGroup ON Artist.ArtistId = ArtistMusicGroup.ArtistId`.

**Expected outcome:** All artists appear. Elvis Presley shows `NULL` in `MusicGroupId`. All existing group memberships appear normally.

**Answer:** [05-joins.sql](../exercise-answers/05-joins.sql)
