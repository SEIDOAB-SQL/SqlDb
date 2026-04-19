USE music;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artist](
	[ArtistId]  [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[FirstName] [nvarchar](100)    NULL,
	[LastName]  [nvarchar](100)    NULL,
	[BirthDay]  [date]             NULL
)
GO
