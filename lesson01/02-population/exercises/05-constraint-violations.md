# Lesson 02 – Exercises: Constraint Violations

These exercises explore what happens when `INSERT` or `UPDATE` statements break the rules defined by **foreign key constraints** and **check constraints**. You will deliberately trigger constraint errors, read the error messages, and understand what SQL Server is enforcing.

Run all population scripts (`01`–`05` in `02-theory/`) before starting so the tables contain data.

---

## Foreign Key Constraints

A foreign key constraint ensures that a value in a child column always refers to an existing row in the parent table. Attempting to insert or update a child row with a value that does not exist in the parent — or to delete a parent row that is still referenced — will fail.

---

### Exercise 1 – Insert a `Pet` with a non-existent owner

**Task:** Attempt to insert a pet whose `OwnerId` does not exist in the `Friend` table.

```sql
USE friends;
GO

INSERT INTO Pet (AnimalKind, Name, AnimalMood, OwnerId)
VALUES ('Dog', 'Ghost', 'Happy', '00000000-0000-0000-0000-000000000000');
```

**Questions:**
- What error message does SQL Server return?
- Which constraint is violated? (Look for the constraint name in the message.)
- Why does SQL Server reject the insert even though the `uniqueidentifier` value is technically valid?

**Expected outcome:** The insert fails with a `FOREIGN KEY constraint` violation error referencing `FK_Pet_Friend`.

---

### Exercise 2 – Insert a `Friend` with a non-existent address

**Task:** Attempt to insert a friend whose `AddressId` does not exist in the `Address` table.

```sql
USE friends;
GO

INSERT INTO Friend (FirstName, LastName, AddressId)
VALUES ('Fake', 'Friend', 'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee');
```

**Questions:**
- Which foreign key constraint is violated?
- What would you need to do first to make this insert succeed with a real address?

**Expected outcome:** The insert fails with a `FOREIGN KEY constraint` violation referencing `FK_Friend_Address`.

---

### Exercise 3 – Delete a `Friend` that still owns pets

**Task:** Attempt to delete a friend who has at least one pet in the `Pet` table.

```sql
USE friends;
GO

DELETE FROM Friend
WHERE FirstName = 'Harry' AND LastName = 'Took';
```

**Questions:**
- What error message does SQL Server return?
- Which pet rows are blocking the delete?
- What two approaches could you take to make the delete succeed?
  1. Delete in the correct order.
  2. *(Advanced)* Use `ON DELETE CASCADE` on the FK definition.

**Expected outcome:** The delete fails with a `REFERENCE constraint` violation referencing `FK_Pet_Friend`.

---

### Exercise 4 – Delete an `Address` that is assigned to friends

**Task:** Attempt to delete an address that is still referenced by one or more friends.

```sql
USE friends;
GO

DELETE FROM Address
WHERE StreetAddress = 'Svedjevägen 1';
```

**Questions:**
- Which constraint blocks the delete?
- List the steps needed to safely remove this address and all data that depends on it.

**Expected outcome:** The delete fails with a `REFERENCE constraint` violation referencing `FK_Friend_Address`.

---

### Exercise 5 – Insert into `FriendQuote` with a non-existent quote

**Task:** Attempt to insert a row into the `FriendQuote` join table using a `QuoteId` that does not exist.

```sql
USE friends;
GO

DECLARE @Harry uniqueidentifier =
    (SELECT FriendId FROM Friend WHERE FirstName = 'Harry' AND LastName = 'Took');

INSERT INTO FriendQuote (FriendId, QuoteId)
VALUES (@Harry, '00000000-0000-0000-0000-000000000001');
```

**Questions:**
- Which of the two FK constraints on `FriendQuote` is violated?
- Would the insert also fail if `@Harry` were `NULL`? Why?

**Expected outcome:** The insert fails with a `FOREIGN KEY constraint` violation referencing `FK_FriendQuote_Quote`.

---

## Check Constraints

A check constraint restricts the values a column will accept to a defined set or expression. Attempting to insert or update a row with a value outside that set will fail.

---

### Exercise 6 – Insert a `Pet` with an invalid `AnimalKind`

**Task:** Attempt to insert a pet with an `AnimalKind` value that is not in the allowed list.

```sql
USE friends;
GO

DECLARE @Harry uniqueidentifier =
    (SELECT FriendId FROM Friend WHERE FirstName = 'Harry' AND LastName = 'Took');

INSERT INTO Pet (AnimalKind, Name, AnimalMood, OwnerId)
VALUES ('Dragon', 'Norbert', 'Happy', @Harry);
```

**Allowed values:** `Dog`, `Cat`, `Rabbit`, `Fish`, `Bird`

**Questions:**
- What error message does SQL Server return?
- Which constraint is named in the message?
- Is `'dragon'` (lowercase) also rejected? Try it.

**Expected outcome:** The insert fails with a `CHECK constraint` violation referencing `CK_Pet_AnimalKind`.

---

### Exercise 7 – Insert a `Pet` with an invalid `AnimalMood`

**Task:** Attempt to insert a pet with an `AnimalMood` value that is not in the allowed list.

```sql
USE friends;
GO

DECLARE @Sam uniqueidentifier =
    (SELECT FriendId FROM Friend WHERE FirstName = 'Sam' AND LastName = 'Baggins');

INSERT INTO Pet (AnimalKind, Name, AnimalMood, OwnerId)
VALUES ('Cat', 'Fluffy', 'Excited', @Sam);
```

**Allowed values:** `Happy`, `Hungry`, `Lazy`, `Sulky`, `Buzy`, `Sleepy`

**Questions:**
- Which constraint is violated?
- What happens if you change `AnimalMood` to `NULL`? Is `NULL` allowed?

**Expected outcome:** The insert fails with a `CHECK constraint` violation referencing `CK_Pet_AnimalMood`.

---

### Exercise 8 – Update a `Pet` to an invalid `AnimalKind`

**Task:** Constraints apply to `UPDATE` statements too. Attempt to change an existing pet's kind to an invalid value.

```sql
USE friends;
GO

UPDATE Pet
SET AnimalKind = 'Unicorn'
WHERE Name = 'Charlie';
```

**Questions:**
- Does an `UPDATE` trigger the same check constraint as an `INSERT`?
- What would the correct value need to be to make this update succeed?

**Expected outcome:** The update fails with a `CHECK constraint` violation referencing `CK_Pet_AnimalKind`.

---

## Summary

| Constraint type | Triggered by | Error phrase |
|---|---|---|
| `FOREIGN KEY` (insert/update child) | Referencing a parent row that does not exist | *conflicted with the FOREIGN KEY constraint* |
| `FOREIGN KEY` (delete/update parent) | Removing a parent row that is still referenced | *conflicted with the REFERENCE constraint* |
| `CHECK` | Inserting or updating a value outside the allowed set | *conflicted with the CHECK constraint* |
