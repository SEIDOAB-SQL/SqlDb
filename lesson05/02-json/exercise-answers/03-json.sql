USE sakila;
GO

-- ============================================================
-- Exercise 1 – Output query results as JSON (FOR JSON PATH)
-- ============================================================

-- Directly inspect the JSON output
SELECT TOP 5
    f.film_id,
    f.title,
    f.release_year,
    f.rating,
    a.first_name,
    a.last_name
FROM dbo.film f
INNER JOIN dbo.film_actor fa ON f.film_id = fa.film_id
INNER JOIN dbo.actor a      ON fa.actor_id = a.actor_id
FOR JSON PATH;

-- Store in a variable and display
DECLARE @filmJSON NVARCHAR(MAX);

SET @filmJSON = (
    SELECT TOP 5
        f.film_id,
        f.title,
        f.release_year,
        f.rating,
        a.first_name,
        a.last_name
    FROM dbo.film f
    INNER JOIN dbo.film_actor fa ON f.film_id = fa.film_id
    INNER JOIN dbo.actor a      ON fa.actor_id = a.actor_id
    FOR JSON PATH
);

SELECT @filmJSON;
GO