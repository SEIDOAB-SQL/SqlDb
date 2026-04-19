# Lesson 03 – Exercises: Querying the Music Database

Use the `music` database for all exercises. Run the schema (Lesson 01) and populate scripts (Lesson 02) first.

The database has three tables:

| Table | Key columns |
|---|---|
| `Artist` | `ArtistId`, `FirstName`, `LastName`, `BirthDay` |
| `MusicGroup` | `MusicGroupId`, `Name`, `EstablishedYear`, `Genre` |
| `Album` | `AlbumId`, `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` |

---

## Exercise 1 – Basic SELECT

**Task:** Write a query that returns **all columns** from the `MusicGroup` table.

**Expected outcome:** Every music group row is displayed.

**Answer:** [01-select.sql](../03-exercise-answers/01-select.sql)

---

## Exercise 2 – Selecting specific columns

**Task:** Write a query that returns only the `Name` and `Genre` columns from `MusicGroup`.

**Expected outcome:** Two columns — no IDs or other fields.

**Answer:** [01-select.sql](../03-exercise-answers/01-select.sql)

---

## Exercise 3 – DISTINCT genres

**Task:** The `MusicGroup` table stores a `Genre` for every group. Write a query that returns each genre **only once**, sorted alphabetically.

**Hint:** Use `DISTINCT` and `ORDER BY`.

**Expected outcome:** 4 rows — `Blues`, `Jazz`, `Metal`, `Rock`.

**Answer:** [01-select.sql](../03-exercise-answers/01-select.sql)

---

## Exercise 4 – WHERE: filter by genre

**Task:** Return the `Name` and `EstablishedYear` of all music groups whose `Genre` is `'Rock'`.

**Expected outcome:** The Rolling Stones, Led Zeppelin, AC/DC.

**Answer:** [02-where.sql](../03-exercise-answers/02-where.sql)

---

## Exercise 5 – WHERE: albums sold more than 10 million copies

**Task:** Return the `Name` and `CopiesSold` of every album where `CopiesSold` is greater than `10000000`.

**Expected outcome:** Led Zeppelin IV, The Black Album, Back in Black, Highway to Hell (check your data).

**Answer:** [02-where.sql](../03-exercise-answers/02-where.sql)

---

## Exercise 6 – WHERE: artists with no known birthday

**Task:** Return the `FirstName` and `LastName` of all artists whose `BirthDay` is `NULL`.

**Hint:** Use `IS NULL`, not `= NULL`.

**Expected outcome:** Artists inserted without a birth date (e.g. James Hetfield, Lars Ulrich).

**Answer:** [02-where.sql](../03-exercise-answers/02-where.sql)

---

## Exercise 7 – ORDER BY: albums by release year

**Task:** Return `Name` and `ReleaseYear` from `Album`, ordered from **oldest to newest**.

**Expected outcome:** All albums in ascending release-year order.

**Answer:** [03-orderby.sql](../03-exercise-answers/03-orderby.sql)

---

## Exercise 8 – ORDER BY: top 5 best-selling albums

**Task:** Return the `Name` and `CopiesSold` of the **5 best-selling albums**, highest first.

**Hint:** Use `ORDER BY … DESC` combined with `TOP 5`.

**Expected outcome:** Back in Black at the top.

**Answer:** [03-orderby.sql](../03-exercise-answers/03-orderby.sql)

---

## Exercise 9 – GROUP BY: count albums per music group

**Task:** Write a query that shows each `MusicGroupId` alongside the number of albums it has.

**Hint:** Use `COUNT(*)` and `GROUP BY MusicGroupId`.

**Expected outcome:** One row per music group that has at least one album, with a count column.

**Answer:** [04-groupby.sql](../03-exercise-answers/04-groupby.sql)

---


## Exercise 12 – HAVING: groups with more than one album

**Task:** Return each `MusicGroupId` that has **more than one album**, along with its album count.

**Hint:** Use `GROUP BY` then filter with `HAVING COUNT(*) > 1`.

**Expected outcome:** Music groups that released multiple albums (e.g. Metallica, Led Zeppelin, AC/DC, Black Sabbath, The Rolling Stones).

**Answer:** [05-having.sql](../03-exercise-answers/05-having.sql)

---

## Exercise 13 – ORDER BY on a grouped result

**Task:** Return each `Genre` and the number of music groups in that genre, **ordered by group count descending**.

**Expected outcome:** The genre with the most groups appears first.

**Answer:** [05-having.sql](../03-exercise-answers/05-having.sql)
