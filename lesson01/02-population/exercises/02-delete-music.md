# Lesson 02 – Exercises: Deleting Data from the Music Database

These exercises explore how foreign key constraints affect the order in which rows must be deleted. They mirror `06-delete-population.sql` from the theory folder, applied to the `music` database.

Run your population scripts (Exercises 1–4 in `01-populate-music.md`) before starting so that the tables contain data.

---

## Exercise 1 – Delete All Data from the Music Database

**Task:** Write a script that deletes all rows from every table in the `music` database, mirroring `06-delete-population.sql` from the theory folder.

**Tables to clear:**

| Table | Has FK dependencies? |
|---|---|
| `ArtistMusicGroup` | Yes — references `Artist` and `MusicGroup` |
| `Album` | Yes — references `MusicGroup` |
| `Artist` | Referenced by `ArtistMusicGroup` |
| `MusicGroup` | Referenced by `Album` and `ArtistMusicGroup` |

**Hints:**
- You must delete **child rows before parent rows**. A foreign key constraint prevents deleting a parent row that is still referenced by a child.
- Delete from the join table `ArtistMusicGroup` first — it references both `Artist` and `MusicGroup`.
- Delete from `Album` before `MusicGroup` — `Album.MusicGroupId` references `MusicGroup`.
- Use a separate `GO` batch separator after each `DELETE` statement, as in the theory script.

**Expected outcome:** All four tables are empty. The script runs without constraint violation errors.

**Suggested solution:** [05-delete-music.sql](../02-exercise-answers/05-delete-music.sql)

---

## Exercise 2 – What Happens with the Wrong Delete Order?

**Task:** Deliberately write the `DELETE` statements in the **wrong order** (parents before children) and observe the error.

**Steps:**
1. Repopulate the `music` database by running your Exercise 1–4 scripts from `01-populate-music.md`.
2. Write a script that attempts to delete in this incorrect order:
   ```sql
   DELETE FROM MusicGroup;   -- parent deleted first
   DELETE FROM Album;
   DELETE FROM Artist;
   DELETE FROM ArtistMusicGroup;
   ```
3. Run it and read the error message carefully.

**Questions to answer:**
- Which `DELETE` statement causes the error?
- Which foreign key constraint is violated?
- Why does SQL Server block the deletion?
- How does correcting the order fix the problem?

**Expected outcome:** The first `DELETE` fails with a message similar to:
> *The DELETE statement conflicted with the REFERENCE constraint …*

This confirms that SQL Server enforces referential integrity and that delete order matters when foreign keys are in place.
