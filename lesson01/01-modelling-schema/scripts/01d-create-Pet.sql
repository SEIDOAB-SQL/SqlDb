USE friends;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet](
	[PetId] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[AnimalKind] [nvarchar](50) NULL,
	[AnimalMood] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
)
GO