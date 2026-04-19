USE friends;
GO

ALTER TABLE [dbo].[Address]
    ADD CONSTRAINT [PK_Address] PRIMARY KEY ([AddressId]);
GO

ALTER TABLE [dbo].[Friend]
    ADD CONSTRAINT [PK_Friend] PRIMARY KEY ([FriendId]);
GO

ALTER TABLE [dbo].[Pet]
    ADD CONSTRAINT [PK_Pet] PRIMARY KEY ([PetId]);
GO

ALTER TABLE [dbo].[Quote]
    ADD CONSTRAINT [PK_Quote] PRIMARY KEY ([QuoteId]);
GO
