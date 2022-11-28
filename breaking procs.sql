SELECT * FROM dimDate;

--Scalar function to convert caldate to a DateID
       

SELECT *, [AD\ID].getDateID(StartTime) AS EndDateID
FROM dwTaskFacts;

--SELECT LEFT(StartTime,10) FROM dwTaskFacts; LEFT parse does not work
SELECT * FROM dwTaskFacts;
SELECT * FROM dimDate;

SELECT DATEPART(hour,StartTime), DATEPART(hour,EndTime)
FROM dwTaskFacts;

SELECT CONVERT(date, StartTime) FROM dwTaskFacts;

SELECT TaskID, CONVERT(date, StartTime), DATEPART(hour,StartTime)
FROM dwTaskFacts;

SELECT LEFT(CONVERT(Date, StartTime),10) FROM dwTaskFacts;
SELECT DATEADD(HOUR,HourOfDay,CONVERT(datetime, CalDate))
FROM dimDate;

DELETE FROM dimDate;
SELECT * FROM dimDate;

ALTER PROC fillDates
(@StartDate DATETIME, @EndDate DATETIME)
AS
BEGIN
WHILE @StartDate < @EndDate    
BEGIN
INSERT INTO dimDate
VALUES (@StartDate, DATENAME(WEEKDAY, @StartDate),
--Hour of day added
DATEPART(HOUR, @StartDate),
DATEPART(WEEK, @StartDate), DATEPART(MONTH, @StartDate), DATEPART(QUARTER, @StartDate), YEAR(@StartDate),  getDate());
SET @StartDate = DATEADD(Hour, 1, @StartDate);
END;
END;
GO

SELECT * FROM dimDate;
SELECT * FROM Employee;
