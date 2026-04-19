USE friends;
GO

--Let's first create an application Error log table
DROP TABLE IF EXISTS dbo.ErrorLog; --Housecleaning for the example     
CREATE TABLE dbo.ErrorLog(
    err_nr INT,
    err_msg NVARCHAR(400),
    err_line INT,
    err_sev INT);
GO

--Create a stored procedure that inserts an Address into the dbo.Address table
--Putting it together, return code, default parameters and output parameters with
--Transactions and Error Handling and logging
CREATE OR ALTER PROCEDURE dbo.usp_InsertAddress
    @StreetAddress  NVARCHAR(200) = NULL,
    @ZipCode        INT = NULL,
    @City           NVARCHAR(200) = NULL,
    @Country        NVARCHAR(200) = NULL,

    --Use an output variable to return AddressId of inserted, NULL will indicate error
    @InsertedAddressId UNIQUEIDENTIFIER = NULL OUTPUT
    AS

    SET NOCOUNT ON;

    DECLARE @retCode INT;
    SET @InsertedAddressId = NULL;

    -- Table variable to capture the auto-generated AddressId via OUTPUT clause
    DECLARE @InsertedId TABLE (AddressId UNIQUEIDENTIFIER);

    BEGIN TRANSACTION
        BEGIN TRY

            INSERT INTO dbo.Address (StreetAddress, ZipCode, City, Country)
            OUTPUT INSERTED.AddressId INTO @InsertedId
            VALUES (@StreetAddress, @ZipCode, @City, @Country);

            COMMIT;

            --Set the output variable after commit, variables are not rolled back
            SET @InsertedAddressId = (SELECT AddressId FROM @InsertedId);
            SET @retCode = 0;

        END TRY
        BEGIN CATCH

            ROLLBACK;

            --Log the error
            INSERT INTO dbo.ErrorLog (err_nr, err_msg, err_line, err_sev)
            VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY());

            SET @retCode = 1;
            THROW 60000, 'Insert Address Error', 1;

        END CATCH;
    RETURN @retCode;
GO

-- Test the stored procedure
DECLARE @NewAddressId UNIQUEIDENTIFIER;

EXEC dbo.usp_InsertAddress
    @StreetAddress     = '123 Main Street',
    @ZipCode           = 12345,
    @City              = 'Copenhagen',
    @Country           = 'Denmark',
    @InsertedAddressId = @NewAddressId OUTPUT;

SELECT @NewAddressId AS InsertedAddressId;

-- Verify
SELECT * FROM dbo.Address WHERE AddressId = @NewAddressId;
