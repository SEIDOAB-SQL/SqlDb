USE friends;
GO

--Group by Row count
SELECT COUNT(*) AS NrAnimals FROM Address  
GROUP BY Country;
GO

SELECT AnimalKind, COUNT(*) AS NrAnimals FROM Pet
GROUP BY AnimalKind;
GO

SELECT AnimalKind, COUNT(*) AS NrAnimals FROM Pet
WHERE AnimalMood = 'Happy'
GROUP BY AnimalKind;
GO

SELECT Country, COUNT(*) AS NrAddresses FROM [dbo].[Address]
GROUP BY Country;
