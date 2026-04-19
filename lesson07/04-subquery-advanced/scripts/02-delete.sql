USE sakila;
GO

-- Copy customers into a temp table to avoid modifying real data
SELECT customer_id, first_name, last_name
INTO #CustomerDelete
FROM dbo.customer;
GO

-- SELECT to preview which customers will be deleted
SELECT COUNT(*)
FROM #CustomerDelete c
WHERE EXISTS (
    SELECT 1
    FROM dbo.rental r
    WHERE c.customer_id = r.customer_id AND r.return_date IS NULL);

-- DELETE all customers who have not returned a rental
DELETE c
FROM #CustomerDelete c
WHERE EXISTS (
    SELECT 1
    FROM dbo.rental r
    WHERE c.customer_id = r.customer_id AND r.return_date IS NULL);

-- Show remaining rows
SELECT COUNT(*) AS RemainingCustomers FROM #CustomerDelete;

DROP TABLE #CustomerDelete;
GO

