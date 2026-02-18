--SQLQuery4 - CREATE ALL IN ONE.sql

--							CREATE DATABASE

CREATE DATABASE PV_521_DDL
ON
(
	NAME		=	PV_521_DDL,
	FILENAME	=	'D:\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_521_DDL.mdf',
	SIZE		=	  8 MB,
	MAXSIZE		=	500 MB,
	FILEGROWTH	=	  8 MB
)
LOG ON
(
	NAME		=	PV_521_DDL_log,
	FILENAME	=	'D:\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_521_DDL.ldf',
	SIZE		=	  8 MB,
	MAXSIZE		=	500 MB,
	FILEGROWTH	=	  8 MB
)
USE PV_521_DDL

--							CREATE STUDENT BRANCH

CREATE TABLE Directions
(
	direction_id	TINYINT			PRIMARY KEY,
	direction_name	NVARCHAR(150)	NOT NULL,
);

CREATE TABLE Groups
(
	group_id		INT				PRIMARY KEY,
	group_name		NVARCHAR(24)	NOT NULL,
	direction		TINYINT			NOT NULL		--описание поля
	CONSTRAINT FK_Groups_Direction	FOREIGN KEY REFERENCES Directions(direction_id)	--это продолжение предыдущей конструкции
--	CONSTRAINT FK_Имя_ВнешнегоКлюча	FOREIGN KEY REFERENCES Таблица(первичный_ключ_внешней таблицы)
);

CREATE TABLE Students
(
	student_id	INT				PRIMARY KEY IDENTITY(1,1),	--IDENTITY - Autoincrement
	last_name	NVARCHAR(50)	NOT NULL,
	first_name	NVARCHAR(50)	NOT NULL,
	middle_name	NVARCHAR(50)		NULL,
	birth_date	DATE			NOT NULL,
	--group - это ключевое слово языка Transact-SQL. Ключевые слова можно использовать для именования полей,
	--		  но в таком случае их нужно брать в []
	[group]		INT				NOT NULL
	CONSTRAINT Fk_Students_Group	FOREIGN KEY REFERENCES Groups(group_id)
);

--							CREATE SHEDULE

CREATE TABLE Shedule
(
	lesson_id		INT						PRIMARY KEY,
	date			DATE					NOT NULL,
	time			TIME					NOT NULL,
	[group]			INT
	CONSTRAINT		FK_Shedule_Group		FOREIGN KEY		REFERENCES	Groups(group_id),
	discipline		SMALLINT				NOT NULL
	CONSTRAINT		FK_Shedule_Disciplines	FOREIGN KEY		REFERENCES	Disciplines(discipline_id),
	teacher			INT						NOT NULL
	CONSTRAINT		FK_Shedule_Teachers		FOREIGN KEY		REFERENCES	Teachers(teacher_id),
	[subject]		SMALLINT				NOT	NULL,
	status			BIT						NOT NULL,
);

CREATE TABLE HomeWorks
(
	[group]			INT,
	lesson			INT,
	CONSTRAINT		FK_Homeworks_Groups		FOREIGN KEY([group])		REFERENCES	Groups(group_id),
	CONSTRAINT		FK_Homeworks_Shedule	FOREIGN KEY(lesson)			REFERENCES	Shedule(lesson_id),
	task			BINARY(1000)				NULL,
	deadlie			INT							NULL
);

CREATE TABLE ResultsHW
(
	student			INT
	CONSTRAINT		FK_ResultsHW_Students	FOREIGN KEY				REFERENCES	Students(student_id),
	[group]			INT
	CONSTRAINT		FK_ResultsHW_Groups		FOREIGN KEY				REFERENCES	Groups(group_id),
	lesson			INT,
	CONSTRAINT		FK_ResultsHW_Shedule	FOREIGN KEY(lesson)		REFERENCES	Shedule(lesson_id),
	result			BINARY(1000)			NULL,
	report			INT						NULL,
	grade			INT						NULL
);
CREATE TABLE Grades
(
	student INT,
	lesson	INT,
	CONSTRAINT		FK_Grades_Students		FOREIGN KEY(student)		REFERENCES	Students(student_id),
	CONSTRAINT		FK_Grades_Shedule		FOREIGN KEY(lesson)			REFERENCES	Shedule(lesson_id)
);
