USE sakila;
GO

--create a temp table
CREATE TABLE #BinaryTest (
    DataDescription VARCHAR(50),
    BinaryData VARBINARY(MAX));

--fill it with some binary data byte[] in c#
INSERT INTO #BinaryTest (DataDescription, BinaryData)
VALUES 
    ('Test 1', CONVERT(VARBINARY(MAX),'this is test 1')),
    ('Test 2', CONVERT(VARBINARY(MAX),'this is test 2')),
    ('Test 3', CONVERT(VARBINARY(MAX),'this is test 3'));


--show the table data
SELECT DataDescription, BinaryData, 
    CONVERT(VARCHAR(MAX), BinaryData) as [to varchar], 
    DATALENGTH(BinaryData) as [binary size]
FROM #BinaryTest;

--remove the temp table
DROP TABLE #BinaryTest;