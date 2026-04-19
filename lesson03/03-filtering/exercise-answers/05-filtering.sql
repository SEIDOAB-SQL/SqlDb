USE sakila;
GO

-- ============================================================
-- Exercise 1 – Filter with a comparison operator and a variable
-- ============================================================

DECLARE @minDays INT = 6;

SELECT
    rental_id,
    rental_date,
    return_date,
    DATEDIFF(day, rental_date, return_date) AS RentalDays
FROM dbo.rental
WHERE DATEDIFF(day, rental_date, return_date) >= @minDays
ORDER BY RentalDays DESC;
GO

-- ============================================================
-- Exercise 2 – Handle NULL with OR
-- ============================================================

DECLARE @minDays INT = 6;

SELECT
    COUNT(CASE WHEN DATEDIFF(day, rental_date, return_date) >= @minDays THEN 1 END)                             AS RentalsOver6Days,
    COUNT(CASE WHEN DATEDIFF(day, rental_date, return_date) >= @minDays OR return_date IS NULL THEN 1 END)      AS RentalsOver6DaysOrNeverReturned
FROM dbo.rental;
GO

-- ============================================================
-- Exercise 3 – BETWEEN with dates and a variable
-- ============================================================

DECLARE @fromDate DATE = '2005-07-01';
DECLARE @toDate   DATE = '2005-07-31';

SELECT
    rental_id,
    rental_date,
    return_date,
    DATEDIFF(day, rental_date, return_date) AS RentalDays
FROM dbo.rental
WHERE rental_date BETWEEN @fromDate AND @toDate
  AND DATEDIFF(day, rental_date, return_date) >= 5
ORDER BY rental_date;
GO

-- ============================================================
-- Exercise 4 – BETWEEN with dates, including NULLs
-- ============================================================

DECLARE @fromDate DATE = '2005-07-01';
DECLARE @toDate   DATE = '2005-07-31';

SELECT
    rental_id,
    rental_date,
    return_date,
    DATEDIFF(day, rental_date, return_date) AS RentalDays
FROM dbo.rental
WHERE rental_date BETWEEN @fromDate AND @toDate
  AND (DATEDIFF(day, rental_date, return_date) >= 5 OR return_date IS NULL)
ORDER BY RentalDays DESC;
GO

-- ============================================================
-- Exercise 5 – BETWEEN with integers and GROUP BY
-- ============================================================

DECLARE @shortRental INT = 1;
DECLARE @longRental  INT = 3;

SELECT
    DATEDIFF(day, rental_date, return_date) AS RentalDays,
    COUNT(*)                                AS NumberOfRentals
FROM dbo.rental
WHERE DATEDIFF(day, rental_date, return_date) BETWEEN @shortRental AND @longRental
GROUP BY DATEDIFF(day, rental_date, return_date)
ORDER BY RentalDays;
GO

-- ============================================================
-- Exercise 6 – IN operator with strings
-- ============================================================

SELECT *
FROM dbo.customer
WHERE last_name IN ('HUNT', 'ALLEN', 'HARRIS', 'MARTIN');
GO

-- ============================================================
-- Exercise 7 – IN operator with integers
-- ============================================================

SELECT
    DATEDIFF(day, rental_date, return_date) AS RentalDays,
    COUNT(*)                                AS NumberOfRentals
FROM dbo.rental
WHERE DATEDIFF(day, rental_date, return_date) IN (4, 5, 7)
GROUP BY DATEDIFF(day, rental_date, return_date)
ORDER BY RentalDays;
GO

-- ============================================================
-- Exercise 8 – LIKE with wildcard prefix and suffix
-- ============================================================

-- 1. Last name starts with 'S'
SELECT customer_id, first_name, last_name
FROM dbo.customer
WHERE last_name LIKE 'S%';

-- 2. Last name ends with 'SON'
SELECT customer_id, first_name, last_name
FROM dbo.customer
WHERE last_name LIKE '%SON';
GO

-- ============================================================
-- Exercise 9 – LIKE with single-character wildcard
-- ============================================================

SELECT customer_id, first_name, last_name
FROM dbo.customer
WHERE last_name LIKE '_A%'
  AND LEN(last_name) >= 4;
GO

-- ============================================================
-- Exercise 10 – LIKE combined with IN via a subquery
-- ============================================================

-- 1. Films with 'gold' in the title
SELECT title, rating
FROM dbo.film
WHERE title LIKE '%gold%';

-- 2. All films sharing a rating with any 'gold' film
SELECT title, rating
FROM dbo.film
WHERE rating IN (SELECT rating FROM dbo.film WHERE title LIKE '%gold%');
GO
