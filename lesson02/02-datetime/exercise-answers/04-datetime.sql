USE sakila;
GO

-- ============================================================
-- Exercise 1 – Current date and time functions
-- ============================================================

SELECT
    GETDATE()             AS CurrentDateTime,
    SYSDATETIME()         AS PreciseDateTime,
    SYSDATETIMEOFFSET()   AS DateTimeWithOffset;
GO

-- ============================================================
-- Exercise 2 – DATEADD and DATEDIFF
-- ============================================================

SELECT
    rental_id,
    rental_date,
    return_date,
    DATEDIFF(day, rental_date, return_date)  AS DaysRented,
    DATEADD(day, 5, rental_date)             AS ExpectedReturn
FROM dbo.rental
WHERE return_date IS NOT NULL
ORDER BY rental_date;
GO

-- ============================================================
-- Exercise 3 – DATEPART and DATENAME
-- ============================================================

SELECT
    rental_id,
    rental_date,
    DATEPART(year,    rental_date)  AS RentalYear,
    DATENAME(month,   rental_date)  AS RentalMonthName,
    DAY(rental_date)                AS RentalDay,
    DATENAME(weekday, rental_date)  AS RentalWeekday
FROM dbo.rental
WHERE rental_date BETWEEN '2005-05-01 00:00:00' AND '2005-05-31 23:59:59';
GO

-- ============================================================
-- Exercise 4 – EOMONTH and DATEFROMPARTS
-- ============================================================

-- End-of-month dates
SELECT
    EOMONTH(GETDATE())    AS EndOfCurrentMonth,
    EOMONTH(GETDATE(), 1) AS EndOfNextMonth,
    EOMONTH('2026-01-01') AS EndOfJanuary2026;
GO

-- Constructing date/datetime values from parts
SELECT
    DATEFROMPARTS(2010, 6, 15)                    AS ConstructedDate,
    DATETIME2FROMPARTS(2010, 6, 15, 8, 30, 0, 0, 0) AS ConstructedDateTime2;
GO

-- ============================================================
-- Exercise 5 – FORMAT and CONVERT
-- ============================================================

SELECT
    rental_id,
    rental_date,
    CONVERT(varchar, rental_date, 101)           AS USShortDate,
    CONVERT(varchar, rental_date, 102)           AS ISODate,
    CONVERT(varchar, rental_date, 20)            AS StandardDateTime,
    FORMAT(rental_date, 'dd MMMM yyyy')          AS CustomFormat
FROM dbo.rental
WHERE rental_date BETWEEN '2005-05-24 00:00:00' AND '2005-05-25 00:00:00';
GO
