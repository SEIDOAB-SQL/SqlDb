USE sakila;
GO

-- ============================================================
-- Exercise 1 – UNION ALL
-- ============================================================

-- Full distinct first-name counts for both tables
SELECT 'Customers' AS Source, COUNT(DISTINCT first_name) AS DistinctFirstNames FROM dbo.customer
UNION ALL
SELECT 'Actors',              COUNT(DISTINCT first_name)                        FROM dbo.actor;

-- Filtered to names beginning with 'B', ordered by count descending
SELECT 'Customers' AS Source, COUNT(DISTINCT first_name) AS DistinctFirstNames FROM dbo.customer WHERE first_name LIKE 'B%'
UNION ALL
SELECT 'Actors',              COUNT(DISTINCT first_name)                        FROM dbo.actor    WHERE first_name LIKE 'B%'
ORDER BY DistinctFirstNames DESC;
GO

-- ============================================================
-- Exercise 2 – INTERSECT
-- ============================================================

-- 2a: List of first names shared by customers and actors
SELECT first_name FROM dbo.customer
INTERSECT
SELECT first_name FROM dbo.actor
ORDER BY first_name;

-- 2b: Count of shared first names
SELECT COUNT(first_name) AS SharedNameCount
FROM (
    SELECT first_name FROM dbo.customer
    INTERSECT
    SELECT first_name FROM dbo.actor
) AS shared;
GO

-- ============================================================
-- Exercise 3 – EXCEPT
-- ============================================================

-- 3a: List of first names in customer but NOT in actor
SELECT first_name FROM dbo.customer
EXCEPT
SELECT first_name FROM dbo.actor
ORDER BY first_name;

-- 3b: Count using EXCEPT
SELECT COUNT(first_name) AS CustomerOnlyNameCount
FROM (
    SELECT first_name FROM dbo.customer
    EXCEPT
    SELECT first_name FROM dbo.actor
) AS customer_only;

-- 3c: Same count using NOT IN (alternative approach — result should match 3b)
SELECT COUNT(DISTINCT first_name) AS CustomerOnlyNameCount
FROM dbo.customer
WHERE first_name NOT IN (SELECT first_name FROM dbo.actor);
GO
