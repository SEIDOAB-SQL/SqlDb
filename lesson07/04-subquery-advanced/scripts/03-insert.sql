USE sakila;
GO

SELECT f.film_id, f.title, a.first_name, a.last_name 
FROM dbo.film f
    INNER JOIN dbo.film_actor fa ON fa.film_id = f.film_id
    INNER JOIN dbo.actor a ON fa.actor_id = a.actor_id
WHERE f.title = 'ACE GOLDFINGER';

SELECT a.actor_id, a.first_name, a.last_name FROM actor a
  WHERE first_name = 'JENNIFER' AND last_name = 'DAVIS';


-- Copy film_actor into a temp table to avoid modifying real data
SELECT actor_id, film_id, last_update
INTO #FilmActorInsert
FROM dbo.film_actor;

-- Use subqueries for insert into temp table
INSERT INTO #FilmActorInsert (actor_id, film_id, last_update)
VALUES (
  (SELECT a.actor_id FROM actor a
   WHERE first_name = 'JENNIFER' AND last_name = 'DAVIS'),
  (SELECT film_id FROM film f
   WHERE f.title = 'ACE GOLDFINGER'),
   GETDATE());

-- Verify insert
SELECT f.film_id, f.title, a.first_name, a.last_name 
FROM dbo.film f
    INNER JOIN #FilmActorInsert fa ON fa.film_id = f.film_id
    INNER JOIN dbo.actor a ON fa.actor_id = a.actor_id
WHERE f.title = 'ACE GOLDFINGER';

DROP TABLE #FilmActorInsert;
