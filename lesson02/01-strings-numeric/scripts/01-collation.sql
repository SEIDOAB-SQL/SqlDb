USE friends;
GO

-- View collation of the SQL Server
SELECT CONVERT (varchar(256), SERVERPROPERTY('collation'));  
-- or
EXECUTE sp_helpsort;  
GO

-- view the collation setting of a database
SELECT name, collation_name FROM sys.databases;  
-- or
SELECT CONVERT (varchar(256), DATABASEPROPERTYEX('friends','collation')) AS collation_name; 
GO

-- view the collation settings for tables and columns
SELECT t.name TableName, c.name ColumnName, collation_name  
FROM sys.columns c  
inner join sys.tables t on c.object_id = t.object_id;  


-- Set the collation in a query to override the default collation of the database
SELECT PetId, Name, AnimalKind
FROM dbo.Pet
WHERE Name = 'whisker' COLLATE Latin1_General_CS_AS;
GO

-- Set the collation of the Pet table Name column to Case Sensitive (CS)
-- Latin1_General_CS_AS: Case Sensitive, Accent Sensitive
ALTER TABLE [dbo].[Pet]
    ALTER COLUMN [Name] [nvarchar](50) COLLATE Latin1_General_CS_AS NULL;
GO


-- Set the collation of the friends database to Case Sensitive (CS)
-- Latin1_General_CS_AS: Case Sensitive, Accent Sensitive
-- Note: existing column collations are NOT changed automatically;
--       columns that inherited the old collation must be altered separately.
USE tempdb;
GO

ALTER DATABASE friends
    COLLATE Latin1_General_CS_AS;
GO

USE friends;
GO

