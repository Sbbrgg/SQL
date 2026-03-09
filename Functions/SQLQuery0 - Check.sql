--SQLQuery0 - Check.sql
USE PV_521_Import
SET DATEFIRST 1;

--EXEC sp_SelectScheduleFor N'PV_521 ';
--PRINT dbo.GetNextLearningDay(N'PV_521', DEFAULT);
--PRINT dbo.GetNextLearningDate(N'SPU_411', N'2026-03-7');
--PRINT dbo.GetSummerTimeSadness(2025);
--PRINT dbo.GetEasterDate(2026);

EXEC sp_InsertAllHolidaysFor 2028;

SELECT
		 [Дата]		=	[date]
		,[Праздник]	=	holiday_name
FROM DaysOFF, Holidays
WHERE holiday = holiday_id
AND		[date] >= DATEFROMPARTS(2027, 12, 20);