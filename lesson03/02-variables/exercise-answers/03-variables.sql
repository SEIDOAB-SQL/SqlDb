-- ============================================================
-- Exercise 1 – Declare, assign, and modify scalar variables
-- ============================================================
USE sakila;
GO

DECLARE @greeting   NVARCHAR(200)  = N'Hello, sakila!';
DECLARE @rentalRate MONEY          = 4.99;
DECLARE @filmCount  INT            = 100;

SET @greeting   += N' Welcome to the rental store.';
SET @rentalRate  = @rentalRate * 2;
SET @filmCount  += 500;

SELECT @greeting AS Greeting, @rentalRate AS RentalRate, @filmCount AS FilmCount;
GO

-- ============================================================
-- Exercise 2 – Assign a variable from a SELECT
-- ============================================================
USE friends;
GO

DECLARE @petSentence NVARCHAR(200);

SELECT @petSentence = CONCAT_WS(N' ', p.Name, N'the', p.AnimalMood, p.AnimalKind, N'is owned by', f.FirstName, f.LastName)
FROM dbo.Pet AS p
    INNER JOIN dbo.Friend AS f ON p.OwnerId = f.FriendId
WHERE f.LastName = 'Weasley';

SELECT @petSentence AS PetSentence;
PRINT @petSentence;
GO

-- ============================================================
-- Exercise 3 – Use a variable in a WHERE clause
-- ============================================================
USE friends;
GO

DECLARE @petCount  INT;
DECLARE @lastName  NVARCHAR(200) = N'Longbottom';

SELECT @petCount = COUNT(*)
FROM dbo.Pet AS p
    INNER JOIN dbo.Friend AS f ON p.OwnerId = f.FriendId
WHERE f.LastName = @lastName;

SELECT CONCAT(
    (SELECT TOP 1 FirstName FROM dbo.Friend WHERE LastName = @lastName),
    N' ', @lastName, N' owns ', CONVERT(NVARCHAR, @petCount), N' pet(s).'
) AS Summary;
GO

-- ============================================================
-- Exercise 4 – Variable in HAVING
-- ============================================================
USE sakila;
GO

DECLARE @minPaymentTotal MONEY = 120.00;

SELECT
    customer_id,
    SUM(amount) AS TotalPaid
FROM dbo.payment
GROUP BY customer_id
HAVING SUM(amount) >= @minPaymentTotal
ORDER BY TotalPaid DESC;
GO

-- ============================================================
-- Exercise 5 – Chain multiple variable assignments in one SELECT
-- ============================================================
USE sakila;
GO

DECLARE @longestTitle  VARCHAR(255);
DECLARE @longestLength SMALLINT;
DECLARE @longestRating VARCHAR(10);

SELECT TOP 1
    @longestTitle  = title,
    @longestLength = length,
    @longestRating = rating
FROM dbo.film
ORDER BY length DESC;

SELECT
    @longestTitle  AS LongestTitle,
    @longestLength AS LengthMinutes,
    @longestRating AS Rating;
GO
