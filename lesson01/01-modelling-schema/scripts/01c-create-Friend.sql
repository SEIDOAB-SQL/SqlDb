USE friends;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friend](
	[FriendId] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[FirstName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NULL,
	[Email] [nvarchar](200) NULL,
	[Birthday] [date] NULL
)
GO
