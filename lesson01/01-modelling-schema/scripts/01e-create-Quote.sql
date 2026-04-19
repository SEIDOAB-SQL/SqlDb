USE friends;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quote](
	[QuoteId] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[QuoteText] [nvarchar](200) NULL,
	[Author] [nvarchar](200) NULL
)
GO
