# Lesson 02 – Exercises: String Functions

Use the `friends` database for all exercises.

The database has two relevant tables:

| Table | Key columns |
|---|---|
| `Friend` | `FriendId`, `FirstName`, `LastName`, `Email`, `Birthday` |
| `Pet` | `PetId`, `AnimalKind`, `Name`, `AnimalMood`, `OwnerId` |

---

## Exercise 1 – Build a full-name sentence with CONCAT_WS and LEN

**Task:** Write a query against the `Friend` table that produces a single column called `FullName` containing each friend's first and last name separated by a space (e.g. `Harry Took`). Alongside `FullName`, return a second column called `NameLength` showing the number of **characters** in the full name (including the space).

**Hint:** Use `CONCAT_WS` to join the names and `LEN` to count the characters.

**Expected outcome:** 13 rows — one per friend — with their full name and its character length.

**Answer:** [02-strings.sql](../exercise-answers/02-strings.sql)

---

## Exercise 2 – Extract and manipulate the email address

**Task:** Write a query against the `Friend` table that returns the following columns for every friend **who has an email address**:

| Column | Description |
|---|---|
| `FullName` | First and last name separated by a space |
| `EmailDomain` | The part of the email after the `@` sign (e.g. `gmail.com`) |
| `Username` | The part of the email before the `@` sign (e.g. `harry.took`) |

**Hint:** Use `CHARINDEX` to locate the `@` character, then use `SUBSTRING` to extract the two parts.

**Expected outcome:** Only friends with a non-NULL email appear (9 rows). Each row shows the full name, domain, and username derived from the email.

**Answer:** [02-strings.sql](../exercise-answers/02-strings.sql)

---

## Exercise 3 – Replace and describe pet names

**Task:** Write a query against the `Pet` table that builds a descriptive sentence for each pet. The sentence must follow this pattern:

> `<Name> the <AnimalMood> <AnimalKind>`

For example: `Charlie the Happy Cat`

Additionally, use `REPLACE` to swap the word `Buzy` with `Busy` in the final sentence (the source data has a typo).

**Hint:** Use `CONCAT_WS` (or `+`) to assemble the sentence, then wrap it in `REPLACE` to fix the typo.

**Expected outcome:** 18 rows — one sentence per pet — with `Buzy` corrected to `Busy` where applicable.

**Answer:** [02-strings.sql](../exercise-answers/02-strings.sql)
