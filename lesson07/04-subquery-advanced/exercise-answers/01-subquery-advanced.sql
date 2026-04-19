USE friends;
GO

-- =============================================
-- Exercise 1: UPDATE with a Subquery
-- =============================================

-- Step 1: Copy Friend into a temp table
SELECT FriendId, FirstName, LastName, Birthday
INTO #FriendUpdate
FROM dbo.Friend;
GO

-- Step 2: Preview rows with no birthday before update
SELECT COUNT(*) AS NullBirthdaysBeforeUpdate
FROM #FriendUpdate
WHERE Birthday IS NULL;

-- Step 3: Update NULL birthdays to the earliest birthday in the real Friend table
UPDATE #FriendUpdate
SET Birthday = (SELECT MIN(Birthday) FROM dbo.Friend)
WHERE Birthday IS NULL;

-- Step 4: Show all rows to confirm no NULLs remain
SELECT * FROM #FriendUpdate;

-- Step 5: Clean up
DROP TABLE #FriendUpdate;
GO

-- =============================================
-- Exercise 2: DELETE with EXISTS
-- =============================================

-- Step 1: Copy Friend into a temp table
SELECT FriendId, FirstName, LastName
INTO #FriendDelete
FROM dbo.Friend;
GO

-- Step 2: Preview how many friends will be deleted (those with no pets)
SELECT COUNT(*) AS FriendsWithNoPets
FROM #FriendDelete f
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Pet p
    WHERE p.OwnerId = f.FriendId);

-- Step 3: Delete friends who own no pets
DELETE f
FROM #FriendDelete f
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Pet p
    WHERE p.OwnerId = f.FriendId);

-- Step 4: Confirm remaining count
SELECT COUNT(*) AS RemainingFriends FROM #FriendDelete;

-- Step 5: Clean up
DROP TABLE #FriendDelete;
GO

-- =============================================
-- Exercise 3: INSERT with Subqueries
-- =============================================

-- Step 1: Copy Pet into a temp table
SELECT PetId, AnimalKind, AnimalMood, Name, OwnerId
INTO #PetInsert
FROM dbo.Pet;
GO

-- Step 2: Preview existing pets for the target friend before insert
SELECT f.FirstName, f.LastName, p.Name, p.AnimalKind
FROM dbo.Friend f
    INNER JOIN #PetInsert p ON p.OwnerId = f.FriendId
WHERE f.FirstName = 'Alice' AND f.LastName = 'Smith';

-- Step 3: Insert a new pet using a subquery to look up the owner's FriendId
INSERT INTO #PetInsert (PetId, AnimalKind, AnimalMood, Name, OwnerId)
VALUES (
    NEWID(),
    'Dog',
    'Happy',
    'Buddy',
    (SELECT FriendId FROM dbo.Friend WHERE FirstName = 'Alice' AND LastName = 'Smith')
);

-- Step 4: Verify the insert
SELECT f.FirstName, f.LastName, p.Name, p.AnimalKind
FROM dbo.Friend f
    INNER JOIN #PetInsert p ON p.OwnerId = f.FriendId
WHERE f.FirstName = 'Alice' AND f.LastName = 'Smith';

-- Step 5: Clean up
DROP TABLE #PetInsert;
GO
