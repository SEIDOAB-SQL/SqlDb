# Lesson 06 – Exercises: Constraints and Cascade Deletes

> **Database:** `music`
>
> | Table | Key columns |
> |---|---|
> | `Artist` | `ArtistId`, `FirstName`, `LastName`, `BirthDay` |
> | `MusicGroup` | `MusicGroupId`, `Name`, `EstablishedYear`, `Genre` |
> | `Album` | `AlbumId`, `Name`, `ReleaseYear`, `CopiesSold`, `MusicGroupId` |
> | `ArtistMusicGroup` | `ArtistId`, `MusicGroupId` |

---

## Exercise 1 – Alter the Album FK constraint to ON DELETE CASCADE and test the behaviour

**Task:**  

**Part A – Alter the constraint**

SQL Server does not support `ALTER CONSTRAINT` directly. You must drop and re-add the constraint.

1. Alter `FK_Album_MusicGroup` on `dbo.Album` so that deleting a `MusicGroup` row **cascades** and automatically deletes its child `Album` rows.  
   `DROP CONSTRAINT` first, then `ADD CONSTRAINT … ON DELETE CASCADE`.

**Part B – Test the cascade**

2. Insert a test `MusicGroup` row:  
   `('Test Group', 2000, 'Rock')`  
   Capture its generated `MusicGroupId` into a variable.  
3. Insert two test `Album` rows linked to that group.  
4. Confirm the album rows exist: `SELECT` from `Album` filtered by the test group ID.  
5. Delete the test `MusicGroup` row.  
6. Re-run the `SELECT` from step 4. It should now return zero rows — the cascade removed the albums automatically.

**Part C – Revert the constraint (optional cleanup)**

7. Drop and re-add `FK_Album_MusicGroup` again, this time **without** `ON DELETE CASCADE`, to restore the original behaviour.

**Hint:**  
The pattern is: `ALTER TABLE … DROP CONSTRAINT …;` followed by `ALTER TABLE … ADD CONSTRAINT … FOREIGN KEY (…) REFERENCES … ON DELETE CASCADE;`

**Expected outcome:**  
After the `DELETE` in step 5, the `SELECT` in step 6 returns zero rows. The `Album` child rows have been deleted automatically by the cascade. After Part C, a plain `DELETE` of a parent `MusicGroup` row without first removing its albums would again raise a FK violation error.

**Answer:** [03-constraints.sql](../exercise-answers/03-constraints.sql)
