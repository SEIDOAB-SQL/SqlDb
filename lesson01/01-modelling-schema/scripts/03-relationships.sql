USE friends;
GO

-- ============================================================
-- Relationship 1: Friend -> Address  (many-to-one)
-- Many Friends can live at the same Address.
-- Add AddressId FK column to Friend, then constrain it.
-- ============================================================
ALTER TABLE [dbo].[Friend]
    ADD [AddressId] [uniqueidentifier] NULL;
GO

ALTER TABLE [dbo].[Friend]
    ADD CONSTRAINT [FK_Friend_Address]
    FOREIGN KEY ([AddressId])
    REFERENCES [dbo].[Address] ([AddressId]);
GO

-- ============================================================
-- Relationship 2: Pet -> Friend  (many-to-one)
-- Many Pets can be owned by one Friend.
-- Add OwnerId FK column to Pet, then constrain it.
-- ============================================================
ALTER TABLE [dbo].[Pet]
    ADD [OwnerId] [uniqueidentifier] NULL;
GO

ALTER TABLE [dbo].[Pet]
    ADD CONSTRAINT [FK_Pet_Friend]
    FOREIGN KEY ([OwnerId])
    REFERENCES [dbo].[Friend] ([FriendId]);
GO

-- ============================================================
-- Relationship 3: Friend <-> Quote  (many-to-many)
-- A Friend can have many Quotes; a Quote can belong to many Friends.
-- Requires a join table with two foreign keys.
-- ============================================================
CREATE TABLE [dbo].[FriendQuote](
    [FriendId] [uniqueidentifier] NOT NULL,
    [QuoteId]  [uniqueidentifier] NOT NULL,
    CONSTRAINT [PK_FriendQuote]       PRIMARY KEY ([FriendId], [QuoteId]),
    CONSTRAINT [FK_FriendQuote_Friend] FOREIGN KEY ([FriendId])
        REFERENCES [dbo].[Friend] ([FriendId]),
    CONSTRAINT [FK_FriendQuote_Quote]  FOREIGN KEY ([QuoteId])
        REFERENCES [dbo].[Quote] ([QuoteId])
);
GO
