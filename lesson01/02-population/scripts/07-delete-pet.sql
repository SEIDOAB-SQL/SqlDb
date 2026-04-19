USE friends;
GO

DELETE [dbo].[Pet]
WHERE [Name] = 'Wanda';

GO

DELETE [dbo].[Pet]
WHERE [AnimalKind] = 'Bird' AND [AnimalMood] = 'Buzy';

GO
