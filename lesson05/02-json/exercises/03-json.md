# Lesson 05 – Exercise 03: JSON

> **Database:** `sakila`
>
> | Table | Key columns |
> |---|---|
> | `film` | `film_id`, `title`, `description`, `release_year`, `rental_rate`, `rating` |
> | `actor` | `actor_id`, `first_name`, `last_name` |
> | `film_actor` | `film_id`, `actor_id` |

---

## Exercise 1 – Output query results as JSON

**Task:**  
Write a query that joins `film`, `film_actor`, and `actor` to retrieve the top 5 films with their actors. Select `film_id`, `title`, `release_year`, `rating` from `film`, and `first_name`, `last_name` from `actor`. Output the results using `FOR JSON PATH`.  
Store the result in a variable of type `NVARCHAR(MAX)` and then `SELECT` the variable to inspect the JSON string.

**Hint:**  
`FOR JSON PATH` goes at the end of the `SELECT` statement. Wrap the whole query in parentheses when assigning it to a variable, e.g. `SET @json = (SELECT ... FOR JSON PATH)`.

**Expected outcome:**  
A JSON string containing 5 film objects, each with nested actor properties. Selecting the variable should display the raw JSON.

**Answer:** [03-json.sql](../exercise-answers/03-json.sql)
