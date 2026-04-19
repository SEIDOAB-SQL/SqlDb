USE music;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[AlbumId]     [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[Name]        [nvarchar](200)    NULL,
	[ReleaseYear] [int]              NULL,
	[CopiesSold]  [bigint]           NULL
)
GO
