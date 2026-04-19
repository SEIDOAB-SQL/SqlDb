USE friends;
GO

--Preparations
--insert a small and a large binary file into the table
--use openrowset to load a file into the BinaryData
--you need to have moved the json-data file into the sql server docker container:
--   1. open a terminal in the directory of your json files on the computer
--   2. create a directory in the docker container to store the json files: 
--         docker exec -u root sql2022container mkdir /usr/jsonfiles
--   3. copy the json file from your computer into the docker container: 
--         docker cp json-data-example.json sql2022container:/usr/jsonfiles/


--using SELECT INTO contruct and a temp table let's me avoid declaring a table separatly
SELECT friend.* 
INTO #fromJSON
FROM
-- Docker container
OPENROWSET(BULK N'/usr/jsonfiles/json-data-example.json', SINGLE_CLOB) AS json

-- SQL Server Express
-- OPENROWSET(BULK N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\friends3.json', SINGLE_CLOB) AS json

 CROSS APPLY OPENJSON(BulkColumn)
 WITH(
    FriendId UNIQUEIDENTIFIER, FirstName NVARCHAR(200), LastName NVARCHAR(200), 
    Country NVARCHAR(200), Pet NVARCHAR(200)) AS friend

SELECT * FROM #fromJSON


--Using the json data read to update the tables
--1. Always test first by creating a tmp table copying the original table, 
--   although in this case we could also just select from the json data and compare it to the original table. 
--   But let's do an update to show how it works.
SELECT * INTO #tmpFriend FROM Friend
SELECT * FROM #tmpFriend

--2. Update the tmp table with the json data, bulk read
UPDATE tf
    SET tf.FirstName = js.FirstName
FROM #tmpFriend tf
INNER JOIN #fromJSON js ON tf.FriendId = js.FriendId

--3. Check result
SELECT * FROM #tmpFriend


DROP TABLE #fromJSON;
DROP TABLE #tmpFriend


--cleanup: remove the json files from the docker container
--   1. open a terminal in the directory of your json files on the computer
--   2. remove the json files from the docker container:
--         docker exec -u root sql2022container rm -rf /usr/jsonfiles
