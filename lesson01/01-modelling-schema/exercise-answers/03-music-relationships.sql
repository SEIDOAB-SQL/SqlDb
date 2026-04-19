USE music;
GO

-- ============================================================
-- Relationship 1: Album -> MusicGroup  (many-to-one)
-- Many Albums can belong to one MusicGroup.
-- Add MusicGroupId FK column to Album, then constrain it.
-- ============================================================
ALTER TABLE [dbo].[Album]
    ADD [MusicGroupId] [uniqueidentifier] NULL;
GO

ALTER TABLE [dbo].[Album]
    ADD CONSTRAINT [FK_Album_MusicGroup]
    FOREIGN KEY ([MusicGroupId])
    REFERENCES [dbo].[MusicGroup] ([MusicGroupId]);
GO

-- ============================================================
-- Relationship 2: Artist <-> MusicGroup  (many-to-many)
-- An Artist can belong to many MusicGroups; a MusicGroup
-- can have many Artists.
-- Requires a join table with two foreign keys.
-- ============================================================
CREATE TABLE [dbo].[ArtistMusicGroup](
    [ArtistId]     [uniqueidentifier] NOT NULL,
    [MusicGroupId] [uniqueidentifier] NOT NULL,
    CONSTRAINT [PK_ArtistMusicGroup]              PRIMARY KEY ([ArtistId], [MusicGroupId]),
    CONSTRAINT [FK_ArtistMusicGroup_Artist]        FOREIGN KEY ([ArtistId])
        REFERENCES [dbo].[Artist] ([ArtistId]),
    CONSTRAINT [FK_ArtistMusicGroup_MusicGroup]    FOREIGN KEY ([MusicGroupId])
        REFERENCES [dbo].[MusicGroup] ([MusicGroupId])
);
GO
