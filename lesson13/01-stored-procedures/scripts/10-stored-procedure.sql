USE friends
GO

-- DANGER!
-- Here is a dangerous stored procedure, but convenient when you are developing and want to 
-- remove test data and re-populate.

CREATE PROCEDURE dbo.udp_DeleteAllData
AS

    --Warning: This will delete all data from the tables. Use with caution!
    DELETE FROM [dbo].[FriendQuote];
    DELETE FROM [dbo].[Quote];
    DELETE FROM [dbo].[Pet];
    DELETE FROM [dbo].[Friend];
    DELETE FROM [dbo].[Address];
GO


--EXEC dbo.udp_DeleteAllData;