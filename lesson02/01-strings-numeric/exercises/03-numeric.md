# Lesson 02 – Exercises: Numeric Functions

Use the `sakila` database for all exercises.

The exercises use the `film` table:

| Column | Type | Description |
|---|---|---|
| `film_id` | `int` | Primary key |
| `title` | `varchar(255)` | Film title |
| `rental_rate` | `decimal(4,2)` | Rental price per period |
| `replacement_cost` | `decimal(5,2)` | Cost to replace the film |
| `rental_duration` | `tinyint` | Number of days in the rental period |
| `length` | `smallint` | Film length in minutes |

---

## Exercise 1 – Apply a discount with FLOOR, CEILING, and ROUND

**Task:** The rental manager wants to offer a **25% discount** on the `rental_rate` of every film. Write a query that returns the `title` and the discounted price in **three different columns**:

| Column | Rule |
|---|---|
| `DiscountedFloor` | Discounted price rounded **down** to the nearest whole number |
| `DiscountedCeiling` | Discounted price rounded **up** to the nearest whole number |
| `DiscountedRounded` | Discounted price rounded to **2 decimal places** |

Order the results by `rental_rate` descending.

**Hint:** Use `FLOOR`, `CEILING`, and `ROUND`. The discount is `rental_rate * 0.75`.

**Expected outcome:** One row per film showing how the same discounted value looks under each rounding strategy.

**Answer:** [03-numeric.sql](../exercise-answers/03-numeric.sql)

---

## Exercise 2 – Identify odd and even film lengths

**Task:** Write a query that returns the `title` and `length` of all films, along with a third column called `LengthType` that contains the text `'Even'` if the film length is even, or `'Odd'` if the film length is odd.

**Hint:** Use the modulo operator `%`. A value is even when `length % 2 = 0`.

**Note:** Exclude films where `length` is `NULL`.

**Expected outcome:** One row per film with a non-null length. The `LengthType` column correctly labels each film.

**Answer:** [03-numeric.sql](../exercise-answers/03-numeric.sql)

---

## Exercise 3 – Calculate daily rental cost

**Task:** Write a query that returns the `title`, `rental_rate`, `rental_duration`, and a calculated column called `DailyRate` — the cost per day if the rental fee is spread equally across the rental duration. Round `DailyRate` to **2 decimal places**.

Also return a column called `ReplacementMultiple` showing how many times the `rental_rate` fits into the `replacement_cost`, rounded **down** to the nearest whole number.

**Hint:** Use division (`/`) for `DailyRate` and `FLOOR` for `ReplacementMultiple`. Be mindful of integer vs decimal division — cast where necessary.

**Expected outcome:** One row per film with all five columns calculated correctly.

**Answer:** [03-numeric.sql](../exercise-answers/03-numeric.sql)
