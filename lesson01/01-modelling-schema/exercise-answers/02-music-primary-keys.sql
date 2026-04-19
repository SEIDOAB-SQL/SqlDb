USE music;
GO

ALTER TABLE [dbo].[Artist]
    ADD CONSTRAINT [PK_Artist] PRIMARY KEY ([ArtistId]);
GO

ALTER TABLE [dbo].[MusicGroup]
    ADD CONSTRAINT [PK_MusicGroup] PRIMARY KEY ([MusicGroupId]);
GO

ALTER TABLE [dbo].[Album]
    ADD CONSTRAINT [PK_Album] PRIMARY KEY ([AlbumId]);
GO
