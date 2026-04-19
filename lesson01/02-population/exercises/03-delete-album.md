# Lesson 02 – Exercises: Deleting Artists and Groups

These exercises practice targeted `DELETE` statements on the `music` database — both deleting individual rows and understanding how foreign key constraints control the order of deletion. They mirror `07-delete-pet.sql` from the theory folder.

Run your population scripts (Exercises 1–4 in `01-populate-music.md`) before starting.

---

## Exercise 1 – Delete a Single Album by Name

**Task:** Write a `DELETE` statement that removes only the album `'Live at the Regal'` from the `Album` table.

**Hints:**
- Use a `WHERE` clause on the `Name` column to target the specific row.
- Run a `SELECT * FROM Album` before and after to confirm the row is removed.

**Expected outcome:** One row is deleted. All other albums remain.

---

## Exercise 2 – Delete All Albums for a Specific Group

**Task:** Write a script that deletes all albums belonging to `'Metallica'` using the variable-lookup pattern.

```sql
DECLARE @Metallica uniqueidentifier =
    (SELECT MusicGroupId FROM MusicGroup WHERE Name = 'Metallica');

DELETE FROM Album
WHERE MusicGroupId = @Metallica;
```

**Questions:**
- How many rows are deleted?
- Why is it safer to look up `MusicGroupId` by name rather than hard-coding the `uniqueidentifier` value?

**Expected outcome:** All Metallica albums are removed. Albums for other groups are unaffected.
