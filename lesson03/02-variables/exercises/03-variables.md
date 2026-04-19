# Lesson 03 – Exercises: T-SQL Variables

The exercises mix the `friends` and `sakila` databases. Each exercise states which database to use.

---

## Exercise 1 – Declare, assign, and modify scalar variables

**Database:** `sakila`

**Task:** Declare the following three variables and give them initial values inline:

| Variable | Type | Initial value |
|---|---|---|
| `@greeting` | `NVARCHAR(200)` | `'Hello, sakila!'` |
| `@rentalRate` | `MONEY` | `4.99` |
| `@filmCount` | `INT` | `100` |

Then, in separate `SET` statements:
- Append the string `' Welcome to the rental store.'` to `@greeting`.
- Double `@rentalRate`.
- Add `500` to `@filmCount`.

Finally, `SELECT` all three variables in one result row.

**Expected outcome:** One row showing the modified greeting string, the doubled rental rate, and the increased film count.

**Answer:** [03-variables.sql](../exercise-answers/03-variables.sql)

---

## Exercise 2 – Assign a variable from a SELECT

**Database:** `friends`

**Task:** Declare a `NVARCHAR(200)` variable called `@petSentence`. Use a `SELECT` statement to assign it a sentence describing **only the pets owned by the friend with last name `'Weasley'`**. Build the sentence using `CONCAT_WS` in the pattern:

> `<PetName> the <AnimalMood> <AnimalKind> is owned by <FirstName> <LastName>`

After the assignment, display the variable with both `SELECT` and `PRINT`.

**Hint:** Join `Pet` to `Friend` on `OwnerId`. Filter by `f.LastName = 'Weasley'`. If there are multiple pets, the variable will hold the value from the last row evaluated.

**Expected outcome:** The variable contains a sentence describing one of Luna Weasley's pets. The same value appears in the result grid and the Messages tab.

**Answer:** [03-variables.sql](../exercise-answers/03-variables.sql)

---

## Exercise 3 – Use a variable in a WHERE clause

**Database:** `friends`

**Task:** Declare an `INT` variable called `@petCount` and a `NVARCHAR(200)` variable called `@lastName` set to `'Longbottom'`.

Use a `SELECT` with `COUNT(*)` to assign `@petCount` the number of pets owned by the friend with that last name.

Display the result with a formatted message using `SELECT`, e.g.:

> `Neville Longbottom owns 2 pet(s).`

**Hint:** Use `CONCAT` or string concatenation (`+`) together with `CONVERT` to build the message string. Join `Pet` to `Friend`.

**Expected outcome:** A single row containing the formatted sentence with the correct pet count.

**Answer:** [03-variables.sql](../exercise-answers/03-variables.sql)

---

## Exercise 4 – Variable assigned inside a SELECT, used in HAVING

**Database:** `sakila`

**Task:** Declare a `MONEY` variable called `@minPaymentTotal` and set it to ``120.00`.

Write a query against the `payment` table that returns each `customer_id` and their total payments (`SUM(amount)`), but only for customers whose total exceeds `@minPaymentTotal`. Name the aggregated column `TotalPaid`. Order the results by `TotalPaid` descending.

**Hint:** Use `GROUP BY customer_id` and `HAVING SUM(amount) >= @minPaymentTotal`.

**Expected outcome:** A list of customers who have spent more than $120 in total, ordered from highest to lowest spend.

**Answer:** [03-variables.sql](../exercise-answers/03-variables.sql)

---

## Exercise 5 – Chain multiple variable assignments in a single SELECT

**Database:** `sakila`

**Task:** Declare three variables:

| Variable | Type |
|---|---|
| `@longestTitle` | `VARCHAR(255)` |
| `@longestLength` | `SMALLINT` |
| `@longestRating` | `VARCHAR(10)` |

Use a **single `SELECT`** statement (with no `FROM`) to assign all three variables in one go after first finding the film with the longest runtime:

- `@longestLength` — the maximum `length` value in the `film` table (use a subquery or a `SELECT` + `TOP 1 ORDER BY`)
- `@longestTitle` — the `title` of that film
- `@longestRating` — the `rating` of that film

Finally, `SELECT` all three variables together.

**Hint:** Use `SELECT TOP 1` ordered by `length DESC` and assign all three variables from that single row.

**Expected outcome:** One row showing the title, length (in minutes), and rating of the longest film in the sakila catalogue.

**Answer:** [03-variables.sql](../exercise-answers/03-variables.sql)
