# Lesson 02 – Exercises: DateTime Functions

Use the `sakila` database for all exercises.

The exercises use two tables:

| Table | Key columns |
|---|---|
| `rental` | `rental_id`, `rental_date` `(DATETIME)`, `return_date` `(DATETIME)`, `customer_id` |
| `customer` | `customer_id`, `first_name`, `last_name`, `create_date` `(DATETIME)` |

---

## Exercise 1 – Current date and time functions

**Task:** Write a single `SELECT` statement (no `FROM` needed) that returns three columns:

| Column | Source |
|---|---|
| `CurrentDateTime` | Current date and time using `GETDATE()` |
| `PreciseDateTime` | Current date and time with higher precision using `SYSDATETIME()` |
| `DateTimeWithOffset` | Current date, time, and UTC offset using `SYSDATETIMEOFFSET()` |

**Expected outcome:** One row showing the same moment in time expressed three different ways.

**Answer:** [04-datetime.sql](../exercise-answers/04-datetime.sql)

---

## Exercise 2 – DATEADD and DATEDIFF

**Task:** The rental store charges a late fee if a film is returned after the agreed rental period. Write a query against the `rental` table that returns:

| Column | Description |
|---|---|
| `rental_id` | The rental identifier |
| `rental_date` | The original rental date |
| `return_date` | The actual return date |
| `DaysRented` | Number of **days** between `rental_date` and `return_date` |
| `ExpectedReturn` | The expected return date, assuming a **5-day** rental period (`DATEADD`) |

Filter to rentals where `return_date` is not `NULL`. Order by `rental_date`.

**Hint:** Use `DATEDIFF(day, ...)` and `DATEADD(day, 5, ...)`.

**Expected outcome:** One row per completed rental showing how long it was actually rented and when it should have been returned.

**Answer:** [04-datetime.sql](../exercise-answers/04-datetime.sql)

---

## Exercise 3 – DATEPART and DATENAME

**Task:** Write a query against the `rental` table that breaks down each `rental_date` into its components. Return:

| Column | Description |
|---|---|
| `rental_id` | The rental identifier |
| `rental_date` | The original rental date |
| `RentalYear` | Year as a number (`DATEPART`) |
| `RentalMonthName` | Month as text, e.g. `May` (`DATENAME`) |
| `RentalDay` | Day of the month as a number (`DAY`) |
| `RentalWeekday` | Day of the week as text, e.g. `Monday` (`DATENAME`) |

Filter to rentals from **May 2005** only.

**Hint:** Use a `BETWEEN` filter or `DATEPART(month, ...) = 5 AND DATEPART(year, ...) = 2005`.

**Expected outcome:** All rentals from May 2005 with the date broken into readable components.

**Answer:** [04-datetime.sql](../exercise-answers/04-datetime.sql)

---

## Exercise 4 – EOMONTH and DATEFROMPARTS

**Task:** Write two separate queries:

1. Using `EOMONTH`, return three columns (no `FROM` needed):
   - The last day of the **current month**
   - The last day of the **next month**
   - The last day of **January 2026**

2. Using `DATEFROMPARTS` and `DATETIME2FROMPARTS`, build and return these values (no `FROM` needed):
   - The date `15 June 2010` as a `DATE`
   - The datetime `15 June 2010 at 08:30:00` as a `DATETIME2`

**Expected outcome:** Two result sets — one with three end-of-month dates, one with two constructed date/datetime values.

**Answer:** [04-datetime.sql](../exercise-answers/04-datetime.sql)

---

## Exercise 5 – FORMAT and CONVERT

**Task:** Write a query against the `rental` table that displays `rental_date` in four different formatted string representations:

| Column | Format description |
|---|---|
| `USShortDate` | US short date format using `CONVERT` style `101` — `MM/dd/yyyy` |
| `ISODate` | ISO standard date using `CONVERT` style `102` — `yyyy.MM.dd` |
| `StandardDateTime` | ODBC canonical format using `CONVERT` style `20` — `yyyy-MM-dd hh:mm:ss` |
| `CustomFormat` | Custom format using `FORMAT`: `dd MMMM yyyy` (e.g. `24 May 2005`) |

Filter to rentals between `2005-05-24` and `2005-05-25`.

**Hint:** Use `CONVERT(varchar, rental_date, <style>)` and `FORMAT(rental_date, 'dd MMMM yyyy')`.

**Expected outcome:** One row per matching rental with the same date expressed in four different string formats.

**Answer:** [04-datetime.sql](../exercise-answers/04-datetime.sql)
