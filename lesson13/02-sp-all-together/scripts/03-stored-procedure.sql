USE friends;
GO

--Create a stored procedure that inserts a Pet into the dbo.Pet table
--Putting it together, return code, default parameters and output parameters with
--Transactions and Error Handling and logging
CREATE OR ALTER PROCEDURE dbo.usp_InsertPet
    @Name       NVARCHAR(50),
    @AnimalKind NVARCHAR(50) = NULL,
    @AnimalMood NVARCHAR(50) = NULL,
    @OwnerId    UNIQUEIDENTIFIER = NULL,

    --Use an output variable to return PetId of inserted, NULL will indicate error
    @InsertedPetId UNIQUEIDENTIFIER = NULL OUTPUT
    AS

    SET NOCOUNT ON;

    DECLARE @retCode INT;
    SET @InsertedPetId = NULL;

    -- Table variable to capture the auto-generated PetId via OUTPUT clause
    DECLARE @InsertedId TABLE (PetId UNIQUEIDENTIFIER);

    BEGIN TRANSACTION
        BEGIN TRY

            INSERT INTO dbo.Pet (Name, AnimalKind, AnimalMood, OwnerId)
            OUTPUT INSERTED.PetId INTO @InsertedId
            VALUES (@Name, @AnimalKind, @AnimalMood, @OwnerId);

            COMMIT;

            --Set the output variable after commit, variables are not rolled back
            SET @InsertedPetId = (SELECT PetId FROM @InsertedId);
            SET @retCode = 0;

        END TRY
        BEGIN CATCH

            ROLLBACK;

            --Log the error
            INSERT INTO dbo.ErrorLog (err_nr, err_msg, err_line, err_sev)
            VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY());

            SET @retCode = 1;
            THROW 60000, 'Insert Pet Error', 1;

        END CATCH;
    RETURN @retCode;
GO

-- ============================================================
-- Test 1: Insert a pet WITHOUT an owner
-- ============================================================
DECLARE @NewPetId UNIQUEIDENTIFIER;

EXEC dbo.usp_InsertPet
    @Name          = 'Whiskers',
    @AnimalKind    = 'Cat',
    @AnimalMood    = 'Lazy',
    @InsertedPetId = @NewPetId OUTPUT;

PRINT 'Inserted PetId: ' + CAST(@NewPetId AS NVARCHAR(36));

-- Verify pet without owner
SELECT PetId, Name, AnimalKind, AnimalMood, OwnerId
FROM dbo.Pet
WHERE PetId = @NewPetId;
GO

-- ============================================================
-- Test 2: Insert a pet WITH an owner
-- ============================================================
DECLARE @NewFriendId UNIQUEIDENTIFIER;
DECLARE @NewPetId    UNIQUEIDENTIFIER;

-- First insert a friend to use as owner
EXEC dbo.usp_InsertFriend
    @FirstName        = 'Charlie',
    @LastName         = 'Nielsen',
    @Email            = 'charlie.nielsen@example.com',
    @InsertedFriendId = @NewFriendId OUTPUT;

PRINT 'Inserted FriendId (owner): ' + CAST(@NewFriendId AS NVARCHAR(36));

-- Insert the pet linked to that friend
EXEC dbo.usp_InsertPet
    @Name          = 'Buddy',
    @AnimalKind    = 'Dog',
    @AnimalMood    = 'Happy',
    @OwnerId       = @NewFriendId,
    @InsertedPetId = @NewPetId OUTPUT;

PRINT 'Inserted PetId: ' + CAST(@NewPetId AS NVARCHAR(36));

-- Verify pet with owner
SELECT p.Name, p.AnimalKind, p.AnimalMood,
       f.FirstName AS OwnerFirstName, f.LastName AS OwnerLastName
FROM dbo.Pet p
    INNER JOIN dbo.Friend f ON p.OwnerId = f.FriendId
WHERE p.PetId = @NewPetId;
GO
