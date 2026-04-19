USE music;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MusicGroup](
	[MusicGroupId]    [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[Name]            [nvarchar](100)    NULL,
	[EstablishedYear] [int]              NULL,
	[Genre]           [nvarchar](50)     NULL
)
GO
