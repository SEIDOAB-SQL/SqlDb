# Lesson 03 – Exercises: Temporary Tables and Table Variables

Use the `sakila` database for all exercises.

The exercises use the `customer` table:

| Column | Type | Description |
|---|---|---|
| `customer_id` | `int` | Primary key |
| `first_name` | `varchar(45)` | Customer first name |
| `last_name` | `varchar(45)` | Customer last name |
| `create_date` | `datetime` | Date the customer account was created |

---

## Exercise 1 – Temporary table with SELECT INTO

**Task:** Create a temporary table called `#CustomerFirstNames` that contains the **distinct first names** of all customers in the `customer` table. Use the `SELECT INTO` syntax — do **not** declare the table beforehand.

Once the table is populated, write a `SELECT` to display its contents, then drop it with `DROP TABLE`.

**Hint:** Use `SELECT DISTINCT` combined with `INTO #CustomerFirstNames`.

**Expected outcome:** A temporary table containing one row per unique first name found in the `customer` table, displayed as a result set.

**Answer:** [01-temp-tables.sql](../exercise-answers/01-temp-tables.sql)

---

## Exercise 2 – Table variable

**Task:** Create a table variable called `@CustomerSummary` with the following columns:

| Column | Type |
|---|---|
| `customer_id` | `INT` |
| `first_name` | `VARCHAR(45)` |
| `last_name` | `VARCHAR(45)` |
| `DaysSinceCreated` | `INT` |

Populate it by selecting from the `customer` table. The `DaysSinceCreated` column should contain the number of **days** between `create_date` and today (`GETDATE()`).

After inserting, write a `SELECT` to display the table variable contents ordered by `DaysSinceCreated` descending.

**Hint:** Use `DATEDIFF(day, create_date, GETDATE())` for the calculated column. Table variables go out of scope automatically — no `DROP` is needed.

**Expected outcome:** All customers listed with the number of days since their account was created, ordered from longest to most recently created.

**Answer:** [01-temp-tables.sql](../exercise-answers/01-temp-tables.sql)
