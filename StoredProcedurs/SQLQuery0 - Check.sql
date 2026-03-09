--SQLQuery0 - Check.sql

USE PV_521_Import
SET DATEFIRST 1;

--DELETE FROM Schedule WHERE [group]=521 AND [date] >= N'2026-03-07';

EXEC sp_InsertScheduleStacionar N'PV_521', N'%MS SQL Server%', N'Олег', N'2025-12-24';
EXEC sp_InsertScheduleStacionar N'PV_521', N'%ADO.NET%', N'Олег', N'2026-02-04';
EXEC sp_InsertScheduleStacionar N'PV_521', N'%Сетевое%', N'Олег', N'2026-03-09';
EXEC sp_InsertScheduleStacionar N'PV_521', N'%Системное%', N'Олег', DEFAULT;
EXEC sp_InsertScheduleStacionar N'PV_521', N'%HTML/CSS%', N'Олег', DEFAULT;
EXEC sp_InsertScheduleStacionar N'PV_521', N'%JavaScript%', N'Олег', DEFAULT;
EXEC sp_InsertScheduleStacionar N'PV_521', N'%ReactJS%', N'Олег', DEFAULT;
EXEC sp_InsertScheduleStacionar N'PV_521', N'%ASP.NET%', N'Олег', DEFAULT;
EXEC sp_selectScheduleFor	N'PV_521'
