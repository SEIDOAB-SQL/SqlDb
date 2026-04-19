# Lesson 04 – Exercises: Set Operators

Use the `sakila` database for all exercises.

Relevant tables:

| Table | Key columns |
|---|---|
| `customer` | `customer_id`, `first_name`, `last_name` |
| `actor` | `actor_id`, `first_name`, `last_name` |

---

## Exercise 1 – UNION ALL

**Task:** Write a query using `UNION ALL` that produces a summary of how many distinct first names exist in each of the two tables. Return a label column (e.g. `'Customers'` / `'Actors'`) and the count of distinct first names. Name the columns `Source` and `DistinctFirstNames`.

Then extend the query: filter **both** halves so only names beginning with `'B'` are counted. Order the final result by `DistinctFirstNames` descending.

**Hint:** Apply `WHERE first_name LIKE 'B%'` to each `SELECT` before the `UNION ALL`, and place `ORDER BY` only at the very end.

**Expected outcome:** Two rows — one for customers, one for actors — showing how many distinct B-names each table contains, ordered from highest to lowest.

**Answer:** [02-set-operators.sql](../exercise-answers/02-set-operators.sql)

---

## Exercise 2 – INTERSECT

**Task:** Find all first names that appear in **both** the `customer` table and the `actor` table.

1. Write a query that returns the **list** of shared first names using `INTERSECT`.
2. Wrap that query in a subquery to return just the **count** of shared first names.

**Hint:** `SELECT first_name FROM dbo.customer INTERSECT SELECT first_name FROM dbo.actor`. Alias the subquery when counting.

**Expected outcome:** First query: the actual shared names, one per row, alphabetically. Second query: a single integer — the number of names that appear in both tables.

**Answer:** [02-set-operators.sql](../exercise-answers/02-set-operators.sql)

---

## Exercise 3 – EXCEPT

**Task:** Find all first names that appear in the `customer` table but **not** in the `actor` table.

1. Write a query using `EXCEPT` that returns the **list** of those first names.
2. Wrap the query in a subquery to return just the **count**.
3. As an alternative approach, write the count query using `NOT IN` with a subquery instead of `EXCEPT` and confirm the result matches.

**Hint:** Use `SELECT first_name FROM dbo.customer EXCEPT SELECT first_name FROM dbo.actor`. For the `NOT IN` version: `WHERE first_name NOT IN (SELECT first_name FROM dbo.actor)`.

**Expected outcome:** All three queries agree on the count. The first query lists each customer-only first name once.

**Answer:** [02-set-operators.sql](../exercise-answers/02-set-operators.sql)
