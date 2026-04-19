USE friends;
GO

--Create a stored procedure that inserts a Quote into the dbo.Quote table
--Putting it together, return code, default parameters and output parameters with
--Transactions and Error Handling and logging
CREATE OR ALTER PROCEDURE dbo.usp_InsertQuote
    @QuoteText  NVARCHAR(200),
    @Author     NVARCHAR(200) = NULL,

    --Use an output variable to return QuoteId of inserted, NULL will indicate error
    @InsertedQuoteId UNIQUEIDENTIFIER = NULL OUTPUT
    AS

    SET NOCOUNT ON;

    DECLARE @retCode INT;
    SET @InsertedQuoteId = NULL;

    -- Table variable to capture the auto-generated QuoteId via OUTPUT clause
    DECLARE @InsertedId TABLE (QuoteId UNIQUEIDENTIFIER);

    BEGIN TRANSACTION
        BEGIN TRY

            INSERT INTO dbo.Quote (QuoteText, Author)
            OUTPUT INSERTED.QuoteId INTO @InsertedId
            VALUES (@QuoteText, @Author);

            COMMIT;

            --Set the output variable after commit, variables are not rolled back
            SET @InsertedQuoteId = (SELECT QuoteId FROM @InsertedId);
            SET @retCode = 0;

        END TRY
        BEGIN CATCH

            ROLLBACK;

            --Log the error
            INSERT INTO dbo.ErrorLog (err_nr, err_msg, err_line, err_sev)
            VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY());

            SET @retCode = 1;
            THROW 60000, 'Insert Quote Error', 1;

        END CATCH;
    RETURN @retCode;
GO

-- ============================================================
-- Test 1: Insert a quote WITHOUT an author
-- ============================================================
DECLARE @NewQuoteId UNIQUEIDENTIFIER;

EXEC dbo.usp_InsertQuote
    @QuoteText       = 'The only way to do great work is to love what you do.',
    @InsertedQuoteId = @NewQuoteId OUTPUT;

PRINT 'Inserted QuoteId: ' + CAST(@NewQuoteId AS NVARCHAR(36));

-- Verify quote without author
SELECT QuoteId, QuoteText, Author
FROM dbo.Quote
WHERE QuoteId = @NewQuoteId;
GO

-- ============================================================
-- Test 2: Insert a quote WITH an author and link it to a friend
-- ============================================================
DECLARE @NewFriendId UNIQUEIDENTIFIER;
DECLARE @NewQuoteId  UNIQUEIDENTIFIER;

-- Insert the quote with an author first (needed before inserting friend)
EXEC dbo.usp_InsertQuote
    @QuoteText       = 'In the middle of every difficulty lies opportunity.',
    @Author          = 'Albert Einstein',
    @InsertedQuoteId = @NewQuoteId OUTPUT;

PRINT 'Inserted QuoteId: ' + CAST(@NewQuoteId AS NVARCHAR(36));

-- Insert friend and link to the quote via @QuoteId parameter
EXEC dbo.usp_InsertFriend
    @FirstName        = 'Diana',
    @LastName         = 'Larsen',
    @Email            = 'diana.larsen@example.com',
    @QuoteId          = @NewQuoteId,
    @InsertedFriendId = @NewFriendId OUTPUT;

-- Verify friend with linked quote
SELECT f.FirstName, f.LastName, q.QuoteText, q.Author
FROM dbo.FriendQuote fq
    INNER JOIN dbo.Friend f ON fq.FriendId = f.FriendId
    INNER JOIN dbo.Quote  q ON fq.QuoteId  = q.QuoteId
WHERE fq.FriendId = @NewFriendId;
GO
