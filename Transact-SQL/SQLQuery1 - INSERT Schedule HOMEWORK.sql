--SQLQuery1 - INSERT Schedule HOMEWORK.sql

USE PV_521_Import
SET datefirst 1;

DECLARE @group					AS	INT			=	(SELECT group_id			FROM Groups			WHERE	group_name		=	N'Pv_521');
DECLARE	@discipline_Hardware	AS	SMALLINT	=	(SELECT discipline_id		FROM Disciplines	WHERE	discipline_name =	N'Hardware-PC');
DECLARE	@discipline_Prog		AS	SMALLINT	=	(SELECT discipline_id		FROM Disciplines	WHERE	discipline_name =	N'Процедурное программирование на языке C++');
DECLARE	@Teacher_Harware		AS	INT			=	(SELECT teacher_id			FROM Teachers		WHERE	first_name		=	N'Алексей'	AND	last_name LIKE N'Свищев');
DECLARE	@Teacher_Prog			AS	INT			=	(SELECT	teacher_id			FROM Teachers		WHERE	first_name		=	N'Олег'		AND	last_name LIKE N'Ковтун');
DECLARE	@number_of_lesson_HW	AS	INT			=	(SELECT number_of_lessons	FROM Disciplines	WHERE	discipline_id = @discipline_Hardware);
DECLARE	@number_of_lesson_Prog	AS	INT			=	(SELECT number_of_lessons	FROM Disciplines	WHERE	discipline_id = @discipline_Prog);

DECLARE	@start_date	AS	DATE	=	N'2025-12-24';
DECLARE @start_time	AS	TIME	=	(SELECT start_time FROM Groups	WHERE group_id=@group);

DECLARE @count_hardware_lessons	AS INT	=	(SELECT	COUNT(*) FROM Schedule WHERE [group] = @group AND discipline = @discipline_Hardware);
DECLARE	@count_prog_lessons		AS INT	=	(SELECT	COUNT(*) FROM Schedule WHERE [group] = @group AND discipline = @discipline_Prog);

DECLARE	@week			AS	INT	=	1;
DECLARE @study_day		AS	INT	=	1;

DECLARE	@date	AS	DATE	= @start_date;
DECLARE	@time	AS	TIME;

WHILE (@count_hardware_lessons < @number_of_lesson_HW	OR	@count_prog_lessons < @number_of_lesson_Prog)
BEGIN
	
	DECLARE @discipline	AS	SMALLINT = @discipline_Hardware;
	IF (@week % 2 = 1)
	BEGIN
		IF(@study_day = 1)	SET	@discipline = @discipline_Hardware;
		ELSE	SET	@discipline = @discipline_Prog;
	END
	ELSE
	BEGIN
		IF(@study_day = 3)	SET	@discipline = @discipline_Prog;
		ELSE	SET	@discipline = @discipline_Hardware;
	END
	
	IF NOT((@discipline = @discipline_Hardware AND @count_hardware_lessons >= @number_of_lesson_HW) OR (@discipline = @discipline_Prog AND @count_prog_lessons >= @number_of_lesson_Prog))
	BEGIN
		SET @time = @start_time;
		IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date] = @date AND [time] = @time AND [group] = @group)
		BEGIN
			IF (@discipline = @discipline_Hardware) 
			BEGIN
				SET @count_hardware_lessons = @count_hardware_lessons +1;
				--PRINT(FORMATMESSAGE(N'HW %i', @count_hardware_lessons));
				PRINT(N'HW');
			END
			IF (@discipline = @discipline_Prog)
			BEGIN
				SET @count_prog_lessons = @count_prog_lessons + 1;
				PRINT(N'PROC')
				--PRINT(FORMATMESSAGE(N'PROC %i', @count_prog_lessons));
			END
		END
	END
	DECLARE @d	TINYINT = DATEPART(WEEKDAY, @date);
	SET @date = DATEADD(DAY, IIF(@d = 5,3,2), @date);
	
	SET @study_day = @study_day +1;
	IF(@study_day > 3)
	BEGIN
		SET @study_day = 1;
		SET @week = @week +1;
	END

END




