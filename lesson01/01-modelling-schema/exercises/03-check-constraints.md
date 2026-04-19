# Lesson 01 – Exercises: Check Constraints with SQL Scripts in the Music Database

These exercises extend the `music` database by adding a check constraint that enforces the allowed values of the `Genre` column, mirroring what `04-check-constraints.sql` does for the `friends` database.

Run your previous scripts (`01b` – `01d`, `02-music-primary-keys.sql`, `03-music-relationships.sql`) before attempting these exercises.

---

## Reference: C# Enum

The `Genre` column on the `MusicGroup` table is mapped from this C# enum:

```csharp
// MusicGroup.cs
public enum MusicGenre { Rock, Blues, Jazz, Metal }
```

In the database the column stores the **string name** of each enum value, not a numeric code.

---

## Exercise 1 – Add a Check Constraint for `MusicGroup.Genre`

**Task:** Write a script that restricts the `Genre` column on the `MusicGroup` table to only the values defined in the `MusicGenre` enum.

**Hints:**
- Use `ALTER TABLE … ADD CONSTRAINT … CHECK` — the same pattern as `04-check-constraints.sql` in Lesson 01 theory.
- The naming convention is `CK_<TableName>_<ColumnName>`.
- List every enum value as a string literal inside `IN (…)`.

**Expected outcome:** Running the script against the `music` database succeeds without errors. Attempting to insert a row with a `Genre` value that is not `'Rock'`, `'Blues'`, `'Jazz'`, or `'Metal'` is rejected.
