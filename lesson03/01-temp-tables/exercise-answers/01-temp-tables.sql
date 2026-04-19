USE sakila;
GO

-- ============================================================
-- Exercise 1 – Temporary table with SELECT INTO
-- ============================================================

-- SELECT INTO creates and populates #CustomerFirstNames in one step
SELECT DISTINCT first_name
INTO #CustomerFirstNames
FROM dbo.customer;

-- Present the table content
SELECT * FROM #CustomerFirstNames;

-- Clean up
DROP TABLE #CustomerFirstNames;
GO

-- ============================================================
-- Exercise 2 – Table variable
-- ============================================================

DECLARE @CustomerSummary TABLE (
    customer_id       INT,
    first_name        VARCHAR(45),
    last_name         VARCHAR(45),
    DaysSinceCreated  INT
);

-- Populate the table variable
INSERT INTO @CustomerSummary (customer_id, first_name, last_name, DaysSinceCreated)
SELECT
    customer_id,
    first_name,
    last_name,
    DATEDIFF(day, create_date, GETDATE())
FROM dbo.customer;

-- Present the table variable content
SELECT *
FROM @CustomerSummary
ORDER BY DaysSinceCreated DESC;
GO
