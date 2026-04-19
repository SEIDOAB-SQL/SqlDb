USE friends;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressId] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[StreetAddress] [nvarchar](200) NULL,
	[ZipCode] [int] NULL,
	[City] [nvarchar](200) NULL,
	[Country] [nvarchar](200) NULL
)
GO
