USE friends;
GO

-- ALTER FK_Pet_Friend to SET NULL on delete
-- SQL Server does not support ALTER CONSTRAINT, so drop and re-add it

ALTER TABLE [dbo].[Pet]
    DROP CONSTRAINT [FK_Pet_Friend];
GO

ALTER TABLE [dbo].[Pet]
    ADD CONSTRAINT [FK_Pet_Friend]
    FOREIGN KEY ([OwnerId])
    REFERENCES [dbo].[Friend] ([FriendId])
    ON DELETE SET NULL;
GO

-- ALTER FK_FriendQuote_Friend to CASCADE on delete
-- FriendId is NOT NULL and part of the PK, so SET NULL is not possible
-- ON DELETE CASCADE will delete FriendQuote rows when a Friend is deleted

ALTER TABLE [dbo].[FriendQuote]
    DROP CONSTRAINT [FK_FriendQuote_Friend];
GO

ALTER TABLE [dbo].[FriendQuote]
    ADD CONSTRAINT [FK_FriendQuote_Friend]
    FOREIGN KEY ([FriendId])
    REFERENCES [dbo].[Friend] ([FriendId])
    ON DELETE CASCADE;
GO
