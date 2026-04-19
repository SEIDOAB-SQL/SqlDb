USE friends;
GO

-- ============================================================
-- Function: dbo.udf_DaysToBirthday
-- Returns the number of days until the next birthday for a given date.
-- Returns NULL if @Birthday is NULL.
-- ============================================================
CREATE OR ALTER FUNCTION dbo.udf_DaysToBirthday (@Birthday DATETIME )
RETURNS INT AS
BEGIN

RETURN DATEDIFF(DAY, GETDATE(), DATEADD(YEAR,DATEDIFF(YEAR, @Birthday, GETDATE()), @Birthday));
END
GO


-- Test: days to next birthday for each friend
SELECT
    FirstName,
    LastName,
    Birthday,
    dbo.udf_DaysToBirthday(Birthday) AS DaysToNextBirthday
FROM dbo.Friend
ORDER BY DaysToNextBirthday;
