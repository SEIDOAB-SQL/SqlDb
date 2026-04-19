USE friends;
GO

-- ============================================================
-- Check constraint: Pet.AnimalKind
-- Allowed values match the C# enum AnimalKind
-- { Dog, Cat, Rabbit, Fish, Bird }
-- ============================================================
ALTER TABLE [dbo].[Pet]
    ADD CONSTRAINT [CK_Pet_AnimalKind]
    CHECK ([AnimalKind] IN ('Dog', 'Cat', 'Rabbit', 'Fish', 'Bird'));
GO

-- ============================================================
-- Check constraint: Pet.AnimalMood
-- Allowed values match the C# enum AnimalMood
-- { Happy, Hungry, Lazy, Sulky, Buzy, Sleepy }
-- ============================================================
ALTER TABLE [dbo].[Pet]
    ADD CONSTRAINT [CK_Pet_AnimalMood]
    CHECK ([AnimalMood] IN ('Happy', 'Hungry', 'Lazy', 'Sulky', 'Buzy', 'Sleepy'));
GO
