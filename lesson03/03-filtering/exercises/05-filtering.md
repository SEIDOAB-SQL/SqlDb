# Lesson 03 – Exercises: Filtering

Use the `sakila` database for all exercises.

Relevant tables:

| Table | Key columns |
|---|---|
| `rental` | `rental_id`, `rental_date`, `return_date`, `customer_id` |
| `customer` | `customer_id`, `first_name`, `last_name`, `email` |
| `film` | `film_id`, `title`, `rental_rate`, `length`, `rating` |
| `payment` | `payment_id`, `customer_id`, `amount`, `payment_date` |

---

## Exercise 1 – Filter with a comparison operator and a variable

**Task:** Declare an `INT` variable called `@minDays` and set it to `6`. Write a query that returns `rental_id`, `rental_date`, `return_date`, and a calculated column `RentalDays` for all rentals where the number of days between `rental_date` and `return_date` is **greater than or equal to** `@minDays`. Order by `RentalDays` descending.

**Hint:** Use `DATEDIFF(day, rental_date, return_date)`.

**Expected outcome:** All completed rentals lasting 6 or more days, ordered from longest to shortest.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 2 – Handle NULL with OR

**Task:** Using the same `@minDays = 6` variable from Exercise 1, write a query that counts **two** values:

1. The number of rentals lasting 6+ days (excluding `NULL` return dates).
2. The number of rentals lasting 6+ days **or** where `return_date` is `NULL` (films never returned).

Return both counts in a single result row with descriptive column aliases.

**Hint:** Use `OR return_date IS NULL` to include un-returned rentals in the second count.

**Expected outcome:** One row with two counts — the second number will be larger than the first.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 3 – BETWEEN with dates and a variable

**Task:** Declare a `DATE` variable `@fromDate = '2005-07-01'` and `@toDate = '2005-07-31'`. Write a query that returns `rental_id`, `rental_date`, `return_date`, and `RentalDays` for rentals that:

- Were rented **during July 2005** (`BETWEEN @fromDate AND @toDate`), AND
- Lasted **5 or more days** (excluding un-returned films).

Order by `rental_date`.

**Expected outcome:** Rentals from July 2005 that lasted at least 5 days.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 4 – BETWEEN with dates, including NULLs

**Task:** Reuse the July 2005 date range from Exercise 3. Write a query that returns all rentals from that period where the rental lasted **5 or more days OR was never returned** (`return_date IS NULL`). Return `rental_id`, `rental_date`, `return_date`, and `RentalDays`. Order by `RentalDays` descending.

**Hint:** Wrap the duration and NULL check in parentheses: `AND (DATEDIFF(...) >= 5 OR return_date IS NULL)`.

**Expected outcome:** The same rows as Exercise 3 plus any July 2005 rentals that were never returned (`RentalDays` will be `NULL` for those rows).

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 5 – BETWEEN with integers and GROUP BY

**Task:** Declare `@shortRental INT = 1` and `@longRental INT = 3`. Write a query that shows how many rentals lasted exactly 1, 2, or 3 days. Return `RentalDays` and `NumberOfRentals`. Order by `RentalDays`.

**Hint:** Use `DATEDIFF(day, ...) BETWEEN @shortRental AND @longRental` and `GROUP BY DATEDIFF(...)`.

**Expected outcome:** Up to 3 rows — one per rental duration — showing the count for each.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 6 – IN operator with strings

**Task:** Write a query that returns all columns from the `customer` table for customers whose `last_name` is one of: `'HUNT'`, `'ALLEN'`, `'HARRIS'`, or `'MARTIN'`.

**Hint:** Use the `IN` operator. Recall that the default server collation is case-insensitive, so casing does not matter.

**Expected outcome:** All customers whose last name matches any of the four names.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 7 – IN operator with integers

**Task:** Write a query that groups rentals by the number of days rented and returns only the groups where rental duration is exactly **4, 5, or 7** days. Return `RentalDays` and `NumberOfRentals`, ordered by `RentalDays`.

**Hint:** Use `WHERE DATEDIFF(...) IN (4, 5, 7)` and `GROUP BY DATEDIFF(...)`.

**Expected outcome:** Exactly 3 rows — one per duration — each with a rental count.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 8 – LIKE with a wildcard prefix and suffix

**Task:** Write two separate queries against the `customer` table:

1. Return all customers whose `last_name` **starts with** `'S'`.
2. Return all customers whose `last_name` **ends with** `'SON'`.

**Hint:** Use `LIKE 'S%'` and `LIKE '%SON'`.

**Expected outcome:** Two result sets — the first with all S-surname customers, the second with all customers whose name ends in SON.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 9 – LIKE with the single-character wildcard

**Task:** Write a query against the `customer` table that returns all customers where the **second letter** of `last_name` is `'A'` and the name is at least 4 characters long.

**Hint:** Use `LIKE '_A%'` combined with a length condition, or simply rely on the pattern naturally requiring at least 2 characters and add `AND LEN(last_name) >= 4`.

**Expected outcome:** Customers whose last name has `A` in the second position and is 4 or more characters long.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)

---

## Exercise 10 – LIKE combined with IN via a subquery

**Task:** Write a query against the `film` table that returns the `title` and `rating` of all films whose title contains the word `'gold'` (anywhere in the title). Then, extend the query: return all films that share the **same rating** as any film whose title contains `'gold'` — including films whose titles do not contain `'gold'`.

Present both results:

1. First query: films with `'gold'` in the title.
2. Second query: all films that share a rating with those films (use the first query as a subquery inside `IN`).

**Hint:** `WHERE rating IN (SELECT rating FROM film WHERE title LIKE '%gold%')`.

**Expected outcome:** The first result set shows only gold-titled films. The second is a larger set of all films sharing those ratings.

**Answer:** [05-filtering.sql](../exercise-answers/05-filtering.sql)
