--SQLQuery4 - SELECT Teachers-Disciplines.sql
USE PV_521_Import

GO

--Дисциплина - кол-во преподавателей

SELECT
	 Disciplines.discipline_name AS [Дисциплина]
	,
	(
		SELECT
			COUNT(*)
		FROM TeachersDisciplinesRelation
		WHERE Disciplines.discipline_id = TeachersDisciplinesRelation.discipline
	)	AS [количество преподавателей]
FROM Disciplines

--Направление кол-во групп кол-во студентов

SELECT 
	
	 Directions.direction_name AS [Направление]
	,
	(
		SELECT
			COUNT(*)
		FROM Groups
		WHERE	Groups.direction = Directions.direction_id
	)	AS [Количество групп]
	,
	(
		SELECT
			COUNT(*)
		FROM Students
		WHERE 
		(
			SELECT
				Groups.direction
			FROM Groups
			WHERE Groups.group_id = Students.[group]
		) = Directions.direction_id
	) AS	[Кол-во студентов]
FROM Directions

--ФИ учителя и кол-во предметов

SELECT
	
	 teacher_id AS	[ID учителя]
	,FORMATMESSAGE('%s %s', last_name, first_name) AS [ФИ учитель]
	,
	(
		SELECT 
			COUNT(*)
		FROM TeachersDisciplinesRelation
		WHERE Teachers.teacher_id = TeachersDisciplinesRelation.teacher
	)	AS	[Кол-во предметов]

FROM Teachers

ORDER BY last_name, first_name