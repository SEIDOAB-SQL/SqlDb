USE sakila;
GO

--Preparations
--insert a small and a large binary file into the table
--use openrowset to load a file into the BinaryData
--you need to have moved the image file into the sql server docker container:
--   1. open a terminal in the directory of your image files on the computer
--   2. create a directory in the docker container to store the image files: 
--         docker exec -u root sql2022container mkdir /usr/images
--   3. copy the image file from your computer into the docker container: 
--         docker cp image1.jpg sql2022container:/usr/images/
--         docker cp image2.jpg sql2022container:/usr/images/


--create a temp table
CREATE TABLE #BinaryTest (
    DataDescription VARCHAR(50),
    BinaryData VARBINARY(MAX));

INSERT INTO #BinaryTest(DataDescription, BinaryData)
   SELECT 'image1.jpg, small file 45kB' AS DataDescription,
      * FROM OPENROWSET(BULK N'/usr/images/image1.jpg', SINGLE_BLOB) AS BinaryData;
GO

INSERT INTO #BinaryTest(DataDescription, BinaryData)
   SELECT 'image2.jpg, large file 4.6MB' AS DataDescription,
      * FROM OPENROWSET(BULK N'/usr/images/image2.jpg', SINGLE_BLOB) AS BinaryData;
GO


--show the table data
SELECT DataDescription, BinaryData, 
    CONVERT(VARCHAR(MAX), BinaryData) as [to varchar], 
    DATALENGTH(BinaryData) as [binary size]
FROM #BinaryTest;

--remove the temp table
DROP TABLE #BinaryTest;

--cleanup: remove the image files from the docker container
--   1. open a terminal in the directory of your image files on the computer
--   2. remove the image files from the docker container:
--         docker exec -u root sql2022container rm -rf /usr/images
