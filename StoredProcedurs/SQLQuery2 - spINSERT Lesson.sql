--SQLQuery2 - spINSERT Lesson.sql

USE PV_521_Import
GO

CREATE PROCEDURE	spInsertLesson
	 @group			AS	INT
	,@discipline	AS	SMALLINT
	,@teacher		AS	SMALLINT
	,@date			AS	DATE
	,@time			AS	TIME
AS
BEGIN
	
	IF NOT EXISTS	(SELECT lesson_id	FROM Schedule	WHERE [date] = @date AND [time] = @time AND [group] = @group)
		INSERT Schedule VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date < GETDATE(),1,0));
	
END