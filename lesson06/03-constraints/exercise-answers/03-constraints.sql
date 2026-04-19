USE music;
GO

-- ============================================================
-- Exercise 1 – Alter FK_Album_MusicGroup to ON DELETE CASCADE
--              and test the cascade behaviour
-- ============================================================

-- ── Part A – Alter the constraint ────────────────────────────

-- 1. Alter FK_Album_MusicGroup to CASCADE on delete
--    SQL Server does not support ALTER CONSTRAINT — drop and re-add it.
ALTER TABLE [dbo].[Album]
    DROP CONSTRAINT [FK_Album_MusicGroup];
GO

ALTER TABLE [dbo].[Album]
    ADD CONSTRAINT [FK_Album_MusicGroup]
    FOREIGN KEY ([MusicGroupId])
    REFERENCES [dbo].[MusicGroup] ([MusicGroupId])
    ON DELETE CASCADE;
GO

-- ── Part B – Test the cascade ─────────────────────────────────

-- 2. Insert a test music group and capture its generated ID
DECLARE @TestGroupId UNIQUEIDENTIFIER;

INSERT INTO dbo.MusicGroup (Name, EstablishedYear, Genre)
VALUES ('Test Group', 2000, 'Rock');

SET @TestGroupId = (SELECT MusicGroupId FROM dbo.MusicGroup WHERE Name = 'Test Group');

-- 3. Insert two test albums linked to the test group
INSERT INTO dbo.Album (Name, ReleaseYear, CopiesSold, MusicGroupId)
VALUES
    ('Test Album One', 2001, 100000, @TestGroupId),
    ('Test Album Two', 2003, 200000, @TestGroupId);

-- 4. Confirm the album rows exist before the delete
SELECT * FROM dbo.Album WHERE MusicGroupId = @TestGroupId;

-- 5. Delete the parent MusicGroup row — cascade removes the albums
DELETE FROM dbo.MusicGroup WHERE MusicGroupId = @TestGroupId;

-- 6. Should now return zero rows
SELECT * FROM dbo.Album WHERE MusicGroupId = @TestGroupId;
GO

-- ── Part C – Revert constraint (remove ON DELETE CASCADE) ─────

-- 7. Restore FK_Album_MusicGroup without CASCADE
ALTER TABLE [dbo].[Album]
    DROP CONSTRAINT [FK_Album_MusicGroup];
GO

ALTER TABLE [dbo].[Album]
    ADD CONSTRAINT [FK_Album_MusicGroup]
    FOREIGN KEY ([MusicGroupId])
    REFERENCES [dbo].[MusicGroup] ([MusicGroupId]);
GO
