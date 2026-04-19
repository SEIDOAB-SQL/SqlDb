# Lesson 02 – Exercises: Populating the Music Database

These exercises populate the `music` database using the same variable-lookup pattern introduced in the `friends` theory scripts:

1. Declare a `uniqueidentifier` variable for each referenced row.
2. Set each variable with a scalar subquery: `(SELECT … FROM … WHERE …)`.
3. Use the variables inside a single `INSERT … VALUES` statement.

Run the `music` schema scripts (Lesson 01) before starting.

---

## Reference: Theory scripts to compare against

| Script | Pattern used |
|---|---|
| `02-theory/01-populate-address.sql` | Plain `INSERT … VALUES` |
| `02-theory/02-populate-friend.sql` | Variables for address lookup |
| `02-theory/03-populate-pet.sql` | Variables for friend (owner) lookup |
| `02-theory/05-distribute-quotes.sql` | Variables for both sides of a join table |

---

## Exercise 1 – Populate `MusicGroup`

**Task:** Write a script that inserts at least **4 music groups** into the `MusicGroup` table — one for each `MusicGenre` enum value (`Rock`, `Blues`, `Jazz`, `Metal`).

**Columns to populate:**

| Column | Type | Notes |
|---|---|---|
| `Name` | `nvarchar(100)` | Group name |
| `EstablishedYear` | `int` | Year the group formed |
| `Genre` | `nvarchar(50)` | Must be one of: `Rock`, `Blues`, `Jazz`, `Metal` |

**Hints:**
- `MusicGroupId` has a default of `NEWID()` — omit it from the column list.
- Use a plain `INSERT … VALUES` (no variable lookups needed here — there are no FK references).
- Violating the `CK_MusicGroup_Genre` check constraint will cause an error; use only the four allowed genre names.

**Expected outcome:** 4 rows appear in `MusicGroup`.

**Answer:** [01-populate-musicgroups.sql](../02-exercise-answers/01-populate-musicgroups.sql)

---

## Exercise 2 – Populate `Artist`

**Task:** Write a script that inserts at least **6 artists** into the `Artist` table. Leave `BirthDay` `NULL` for at least two of them.

**Columns to populate:**

| Column | Type | Notes |
|---|---|---|
| `FirstName` | `nvarchar(100)` | |
| `LastName` | `nvarchar(100)` | |
| `BirthDay` | `date` | Nullable — leave `NULL` for some rows |

**Hints:**
- `ArtistId` has a default of `NEWID()` — omit it from the column list.
- Use a plain `INSERT … VALUES` (no FK references on this table).

**Expected outcome:** 6 rows appear in `Artist`, at least two with `NULL` birthday.

**Answer:** [02-populate-artists.sql](../02-exercise-answers/02-populate-artists.sql)

---

## Exercise 3 – Populate `Album`

**Task:** Write a script that inserts at least **6 albums** into the `Album` table, each linked to one of the music groups inserted in Exercise 1.

Use the **variable-lookup pattern** from `02-populate-friend.sql`:
- Declare one `uniqueidentifier` variable per music group.
- Set each variable with `(SELECT MusicGroupId FROM MusicGroup WHERE Name = '…')`.
- Reference the variables in the `INSERT … VALUES` statement.

**Columns to populate:**

| Column | Type | Notes |
|---|---|---|
| `Name` | `nvarchar(100)` | Album title |
| `ReleaseYear` | `int` | |
| `CopiesSold` | `bigint` | Use realistic large numbers |
| `MusicGroupId` | `uniqueidentifier` | FK — use a declared variable |

**Hints:**
- `AlbumId` has a default — omit it.
- Assign at least two albums to the same group so you can later query one-to-many relationships.

**Expected outcome:** 6 rows appear in `Album`, each with a valid `MusicGroupId` that exists in `MusicGroup`.

**Answer:** [03-populate-albums.sql](../02-exercise-answers/03-populate-albums.sql)

---

## Exercise 4 – Link Artists to Music Groups

**Task:** Write a script that populates the `ArtistMusicGroup` join table so that:
- Each artist belongs to at least one group.
- At least two artists share the same group (a band with multiple members).
- At least one artist belongs to two different groups.

Use the **variable-lookup pattern** from `05-distribute-quotes.sql`:
- Declare variables for all artists and all groups.
- Look each one up by name.
- Insert into `ArtistMusicGroup (ArtistId, MusicGroupId)`.

**Hints:**
- The composite primary key `(ArtistId, MusicGroupId)` prevents duplicate pairs — inserting the same combination twice will fail.
- Name `ArtistId` variables after the artist (e.g. `@Jimi`, `@Eric`) and group variables after the group (e.g. `@Bluesband`, `@RockGroup`).

**Expected outcome:** The `ArtistMusicGroup` table contains rows that correctly represent which artists are members of which groups.

**Answer:** [04-link-artists-musicgroups.sql](../02-exercise-answers/04-link-artists-musicgroups.sql)
