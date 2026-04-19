USE sakila;
GO

-- ============================================================
-- Exercise 1 – Apply a discount with FLOOR, CEILING, and ROUND
-- ============================================================

SELECT
    title,
    rental_rate,
    FLOOR(rental_rate * 0.75)        AS DiscountedFloor,
    CEILING(rental_rate * 0.75)      AS DiscountedCeiling,
    ROUND(rental_rate * 0.75, 2)     AS DiscountedRounded
FROM dbo.film
ORDER BY rental_rate DESC;
GO

-- ============================================================
-- Exercise 2 – Identify odd and even film lengths
-- ============================================================

SELECT
    title,
    length,
    CASE
        WHEN length % 2 = 0 THEN 'Even'
        ELSE 'Odd'
    END AS LengthType
FROM dbo.film
WHERE length IS NOT NULL;
GO

-- ============================================================
-- Exercise 3 – Calculate daily rental cost
-- ============================================================

SELECT
    title,
    rental_rate,
    rental_duration,
    ROUND(rental_rate / CAST(rental_duration AS DECIMAL(5,2)), 2)  AS DailyRate,
    FLOOR(replacement_cost / rental_rate)                          AS ReplacementMultiple
FROM dbo.film;
GO
