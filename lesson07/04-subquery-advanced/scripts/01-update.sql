USE sakila;
GO

-- Copy customers into a temp table to avoid modifying real data
SELECT customer_id, first_name, last_name, last_update
INTO #CustomerUpdate
FROM dbo.customer;
GO

UPDATE #CustomerUpdate
SET last_update = '2000-01-01 00:00:00'


--UPDATE customer.last_update with id 4, 5 or 6  to the latest rental date for respective customer
UPDATE #CustomerUpdate
SET last_update =
 (SELECT max(r.rental_date) FROM rental r
  WHERE r.customer_id = c.customer_id)
FROM #CustomerUpdate c
WHERE customer_id IN (4,5,6);

-- Show results
SELECT * FROM #CustomerUpdate;

--UPDATE all customers last_update to the latest rental date for respective customer
UPDATE #CustomerUpdate
SET last_update =
 (SELECT max(r.rental_date) FROM rental r
  WHERE r.customer_id = c.customer_id)
FROM #CustomerUpdate c;

-- Show results
SELECT * FROM #CustomerUpdate;
DROP TABLE #CustomerUpdate;
