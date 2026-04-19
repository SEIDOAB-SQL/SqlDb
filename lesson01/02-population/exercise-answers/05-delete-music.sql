USE music;
GO

-- Warning: This will delete all data from the tables. Use with caution!
-- Order matters: child tables must be deleted before parent tables.

-- 1. Join table first — references both Artist and MusicGroup
DELETE FROM [dbo].[ArtistMusicGroup];
GO

-- 2. Album references MusicGroup
DELETE FROM [dbo].[Album];
GO

-- 3. Artist is now safe to delete (ArtistMusicGroup is already empty)
DELETE FROM [dbo].[Artist];
GO

-- 4. MusicGroup is now safe to delete (Album and ArtistMusicGroup are already empty)
DELETE FROM [dbo].[MusicGroup];
GO
