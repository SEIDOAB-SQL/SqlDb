# Lesson 02 – Exercises: Collation

Use the `friends` database for all exercises.

---

## Exercise 1 – Discover server and database collation

**Task:** Write queries using **two different methods** to answer each of the following:

1. What is the default collation of the SQL Server instance?
2. What is the collation of the `friends` database?

**Hint:** Use `SERVERPROPERTY`, `sp_helpsort`, `sys.databases`, and/or `DATABASEPROPERTYEX`.

**Expected outcome:** The server collation name (e.g. `SQL_Latin1_General_CP1_CI_AS`) and the `friends` database collation name are displayed.

**Answer:** [01-collation.sql](../exercise-answers/01-collation.sql)

---

## Exercise 2 – Inspect column-level collations

**Task:** Write a single query that lists every **table** and **column** in the `friends` database that has a collation assigned. Include the table name, column name, and collation name. Order the results by table name, then column name.

**Hint:** Join `sys.columns` to `sys.tables` and filter out columns where `collation_name` is `NULL`.

**Expected outcome:** Only string-typed columns (e.g. `nvarchar`) appear in the result — integer and date columns are excluded because they have no collation.

**Answer:** [01-collation.sql](../exercise-answers/01-collation.sql)

---

## Exercise 3 – Case-sensitive vs case-insensitive search

**Task:** Write two `SELECT` queries against the `Pet` table, both searching for rows where `Name` equals `'wanda'` (all lowercase).

- The **first** query must force a **case-sensitive** collation using the `COLLATE` keyword.
- The **second** query must force a **case-insensitive** collation using the `COLLATE` keyword.

**Hint:** Try `Latin1_General_CS_AS` (case-sensitive) and `Latin1_General_CI_AS` (case-insensitive).

**Expected outcome:** The case-sensitive query returns **0 rows** because `'wanda'` does not match the stored value `'Wanda'`. The case-insensitive query returns **1 row** — the fish named Wanda.

**Answer:** [01-collation.sql](../exercise-answers/01-collation.sql)
