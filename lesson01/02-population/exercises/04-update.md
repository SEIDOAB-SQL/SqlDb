# Lesson 02 – Exercises: Updating Artists and Groups

These exercises practice `UPDATE` statements on the `music` database — changing column values on individual rows and on sets of rows. They mirror `08-update-pet.sql` from the theory folder.

Run your population scripts (Exercises 1–4 in `01-populate-music.md`) before starting.

---

## Exercise 1 – Update a Single Artist's Birthday

**Task:** Write an `UPDATE` statement that sets the `BirthDay` for `'James Hetfield'` to `'1963-08-03'`.

**Hints:**
- Use `WHERE FirstName = '...' AND LastName = '...'` to target the exact row.
- Run a `SELECT` before and after to verify the change.

**Expected outcome:** James Hetfield's `BirthDay` changes from `NULL` to `1963-08-03`.

---

## Exercise 2 – Update Multiple Artists' Birthdays

**Task:** Two artists currently have `NULL` birthdays. Write `UPDATE` statements to set:
- `Lars Ulrich` — born `'1963-12-26'`
- `Kirk Hammett` — born `'1962-11-18'`

**Hints:**
- Write a separate `UPDATE` for each artist, or combine them using a `CASE` expression.
- Confirm with `SELECT * FROM Artist WHERE BirthDay IS NULL` before and after.

**Expected outcome:** Both artists have a birth date; no `NULL` birthdays remain among Metallica members.

---

## Exercise 3 – Rename a Music Group

**Task:** Write an `UPDATE` that changes the `Name` of `'Miles Davis Quartet'` to `'Miles Davis Group'`.

**Hints:**
- Target the row with `WHERE Name = 'Miles Davis Quartet'`.
- After updating, verify that the `Album` rows for this group are still correctly linked (the FK stores the `MusicGroupId`, not the name, so they are unaffected).

**Expected outcome:** The group name is updated. Its albums still appear when querying by `MusicGroupId`.

---

## Exercise 4 – Update the Genre of a Group

**Task:** Write an `UPDATE` that changes the `Genre` of `'Black Sabbath'` from `'Metal'` to `'Rock'`.

Then attempt to change it to an invalid value:

```sql
UPDATE MusicGroup
SET Genre = 'Grunge'
WHERE Name = 'Black Sabbath';
```

**Questions:**
- Does the first update (to `'Rock'`) succeed?
- Does the second update (to `'Grunge'`) succeed?
- Which constraint blocks the second update?

**Expected outcome:** The first update succeeds. The second fails with a `CHECK constraint` violation referencing `CK_MusicGroup_Genre`.

---

## Exercise 5 – Bulk Update Albums by Group

**Task:** Write a script using the variable-lookup pattern that sets `CopiesSold = 0` for all albums belonging to `'B.B. King Band'`.

```sql
DECLARE @BBKingBand uniqueidentifier =
    (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'B.B. King Band');

UPDATE Album
SET CopiesSold = 0
WHERE MusicGroupId = @BBKingBand;
```

**Questions:**
- How many rows are affected?
- Why is it important to use a variable here rather than filtering by album name?

**Expected outcome:** All B.B. King Band albums have `CopiesSold` set to `0`.

