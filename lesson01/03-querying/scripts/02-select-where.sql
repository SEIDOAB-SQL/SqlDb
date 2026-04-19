USE friends;
GO

SELECT * FROM dbo.Pet;

SELECT AnimalKind FROM dbo.Pet;

SELECT DISTINCT AnimalKind FROM dbo.Pet;
SELECT Name FROM dbo.Pet WHERE AnimalMood = 'Lazy';
SELECT * FROM dbo.Pet WHERE AnimalKind = 'Bird';
