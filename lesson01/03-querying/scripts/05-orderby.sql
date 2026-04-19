USE friends;
GO

-- ORDER BY: all pets alphabetically by name
SELECT Name, AnimalKind, AnimalMood
FROM dbo.Pet
ORDER BY Name ASC;
GO

-- ORDER BY DESC: pets sorted by animal kind descending
SELECT Name, AnimalKind
FROM dbo.Pet
ORDER BY AnimalKind DESC;
GO

-- WHERE + ORDER BY: only happy pets, sorted by name
SELECT Name, AnimalKind
FROM dbo.Pet
WHERE AnimalMood = 'Happy'
ORDER BY Name ASC;
GO

-- WHERE + ORDER BY: addresses in Sweden, sorted by city
SELECT StreetAddress, City, ZipCode
FROM dbo.Address
WHERE Country = 'Sweden'
ORDER BY City ASC;
GO

-- GROUP BY + ORDER BY: count pets per animal kind, most common first
SELECT AnimalKind, COUNT(*) AS NrAnimals
FROM dbo.Pet
GROUP BY AnimalKind
ORDER BY NrAnimals DESC;
GO

-- GROUP BY + ORDER BY: count addresses per country, alphabetical
SELECT Country, COUNT(*) AS NrAddresses
FROM dbo.Address
GROUP BY Country
ORDER BY Country ASC;
GO

-- WHERE + GROUP BY + ORDER BY: count non-lazy pets per kind, highest first
SELECT AnimalKind, COUNT(*) AS NrAnimals
FROM dbo.Pet
WHERE AnimalMood != 'Lazy'
GROUP BY AnimalKind
ORDER BY NrAnimals DESC;
GO

-- GROUP BY + HAVING + ORDER BY: animal kinds with more than 2 pets, sorted by count
SELECT AnimalKind, COUNT(*) AS NrAnimals
FROM dbo.Pet
GROUP BY AnimalKind
HAVING COUNT(*) > 2
ORDER BY NrAnimals DESC;
GO

-- WHERE + GROUP BY + HAVING + ORDER BY: countries (excl. Sweden) with more than 2 cities
SELECT Country, COUNT(City) AS NrCities
FROM dbo.Address
WHERE Country != 'Sweden'
GROUP BY Country
HAVING COUNT(City) > 2
ORDER BY NrCities DESC;
GO
