USE friends;
GO

-- ============================================================
-- Exercise 1 – Build a full-name sentence with CONCAT_WS and LEN
-- ============================================================

SELECT
    CONCAT_WS(N' ', FirstName, LastName)            AS FullName,
    LEN(CONCAT_WS(N' ', FirstName, LastName))       AS NameLength
FROM dbo.Friend;
GO

-- ============================================================
-- Exercise 2 – Extract and manipulate the email address
-- ============================================================

SELECT
    CONCAT_WS(N' ', FirstName, LastName)                                        AS FullName,
    SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email))                    AS EmailDomain,
    SUBSTRING(Email, 1, CHARINDEX('@', Email) - 1)                             AS Username
FROM dbo.Friend
WHERE Email IS NOT NULL;
GO

-- ============================================================
-- Exercise 3 – Replace and describe pet names
-- ============================================================

SELECT
    REPLACE(
        CONCAT_WS(N' ', Name, N'the', AnimalMood, AnimalKind),
        'Buzy',
        'Busy'
    ) AS PetDescription
FROM dbo.Pet;
GO
