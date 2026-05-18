USE [friends];
GO


-- List all stored procedures, scalar UDFs, and table-valued functions
SELECT SCHEMA_NAME(schema_id) + '.' + name AS ObjectName,
       type_desc                            AS ObjectType
FROM   sys.objects
WHERE  type_desc IN (
           'SQL_STORED_PROCEDURE',
           'SQL_SCALAR_FUNCTION',
           'SQL_INLINE_TABLE_VALUED_FUNCTION',
           'SQL_TABLE_VALUED_FUNCTION')
ORDER BY type_desc, ObjectName;