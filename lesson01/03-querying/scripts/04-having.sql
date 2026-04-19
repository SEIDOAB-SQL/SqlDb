USE friends;
GO

-- find the number of animals per kind, but only for kinds with more than 2 animals
SELECT AnimalKind, COUNT(*) AS NrAnimals FROM Pet 
GROUP BY AnimalKind
HAVING COUNT(*) > 2;

--find the countries with more than 2 cities
SELECT Country, COUNT(City) AS NrOfCities FROM [dbo].[Address]
GROUP BY Country
HAVING COUNT(City) > 2;


--find the countries, excluding Sweden, with more than 2 cities
SELECT Country, COUNT(City) AS NrOfCities FROM [dbo].[Address]
WHERE Country != 'Sweden'
GROUP BY Country
HAVING COUNT(City) > 2;

