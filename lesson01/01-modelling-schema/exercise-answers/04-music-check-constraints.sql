USE music;
GO

-- ============================================================
-- Check constraint: MusicGroup.Genre
-- Allowed values match the C# enum MusicGenre
-- { Rock, Blues, Jazz, Metal }
-- ============================================================
ALTER TABLE [dbo].[MusicGroup]
    ADD CONSTRAINT [CK_MusicGroup_Genre]
    CHECK ([Genre] IN ('Rock', 'Blues', 'Jazz', 'Metal'));
GO
