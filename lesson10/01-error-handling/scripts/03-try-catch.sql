USE friends;
GO

--Let's first create an application log table
DROP TABLE IF EXISTS dbo.ErrorLog; --Housecleaning for the example     
CREATE TABLE dbo.ErrorLog(
    err_nr INT,
    err_msg NVARCHAR(400),
    err_line INT,
    err_sev INT);
GO

--You can always throw an error
--;THROW 999999, 'This is a test error.', 1;

BEGIN TRY
    INSERT INTO dbo.Pet
        (PetId, AnimalKind, Name, OwnerId) VALUES 
        ('00000000-0000-0000-0000-000000000000', 'Cat', 'Whiskey', '00000000-0000-0000-0000-000000000000');
END TRY
BEGIN CATCH
    --You can put some corrective in place, such as your application logging   
    INSERT INTO dbo.ErrorLog (err_nr, err_msg, err_line, err_sev)
    VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY())

    --And then THROW the same error again to a client
    --;THROW

    --Or, put alittle more clarity that the standard SQL Error
    ;THROW 999999, 'Error in inserting into dbo.Pet', 1;
END CATCH;
