USE friends;
GO

SELECT * FROM dbo.Pet
WHERE AnimalMood = 'Lazy';

UPDATE Pet
SET AnimalMood = 'Lazy'
WHERE AnimalKind = 'Dog' OR AnimalKind = 'Cat';

SELECT * FROM dbo.Pet
WHERE AnimalMood = 'Lazy';

GO

