SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vWdim_Fecha] AS
	SELECT
		  Fecha_key
		, idFecha
		, FechaCompleta
		, convert(date,FechaCompleta) Date
		, Fecha
		, DiaSemana
		, DiaSemanaTxt
		, IIF(DiaSemanaTxt='Miércoles','X',LEFT(DiaSemanaTxt,1)) DiaSemanaTxtAbr
		, IIF(DiaSemanaTxt='Miércoles','X',LEFT(DiaSemanaTxt,1)) + '-' + CONVERT(NVARCHAR(2),Dia) DiaTxt
		, Mes
		, MesTxt
		, LEFT(MesTxt,3) MesTxtAbr
		, LEFT(MesTxt,3) + '-' + RIGHT(CONVERT(NVARCHAR(4),Año),2) MesAñoTxt
		, Año
		, Dia
		, LEFT(MesTxt,3)+'-'+CONVERT(NVARCHAR(2),Dia) MesDiaTxt
		, SemanaNat
		, Semana
		, SemanaTxt
		, Trimestre
		, TrimestreTxt
		, PeriodoSAP
		, PeriodoSAPtxt
		, PeriodoSAPAnt
		, Es_Festivo
		, Festivo
		, Es_Laborable
		, Laborable
		, Estacion
		, Evento
		, Es_FinMes
		, Es_IniMes
		, Dias_Mes
		, Dias_FinMes
		, IIF(Año = DATEPART(year, GETDATE())
	   			AND Mes <= DATEPART(month, GETDATE())
			 , 1, 0) AS                                                Es_Año_Actual
		, IIF(Año = DATEPART(year, GETDATE())
	   			AND Mes = DATEPART(month, GETDATE())
			 , 1, 0) AS                                                Es_Mes_Actual
		, IIF(Año = DATEPART(year, GETDATE())
	   			AND Mes = DATEPART(month, GETDATE())
			 , 'SI', 'NO') AS                                                Es_Mes_Actual_TXT
		, IIF(Año = DATEPART(year, EOMONTH(getdate(),-1))
	   			AND Mes = DATEPART(month, EOMONTH(getdate(),-1))
			 , 1, 0) AS                                                Es_Mes_Anterior
		, IIF(DATEDIFF(year, FechaCompleta, GETDATE()) BETWEEN 0 AND 6
			 , 1, 0) AS        Es_Año_Rango_6
		, IIF(DATEDIFF(year, FechaCompleta, GETDATE()) BETWEEN 0 AND 3
			 , 1, 0) AS        Es_Año_Rango_3
		, IIF(DATEDIFF(year, FechaCompleta, GETDATE()) BETWEEN 0 AND 2
		      , 1, 0) AS        Es_Año_Rango_2
		, IIF(DATEDIFF(year, FechaCompleta, GETDATE()) BETWEEN 0 AND 1
		      , 1, 0) AS        Es_Año_Rango_1
		, IIF(Año BETWEEN 2011 and DATEPART(year,GETDATE())
			 , 1, 0) AS        Es_Año_RangoDatos
		, IIF(DATEDIFF(month, FechaCompleta, GETDATE()) BETWEEN 1 AND 14, 'Rango12M', 'NoRango12M') AS Rango12M
		, IIF(DATEDIFF(month, FechaCompleta, GETDATE()) BETWEEN 1 AND 6, 'Rango6M', 'NoRango6M') AS    Rango6M
		, IIF(DATEDIFF(month, FechaCompleta, GETDATE()) BETWEEN 1 AND 3, 'Rango3M', 'NoRango3M') AS    Rango3M
		, IIF(DATEDIFF(month, FechaCompleta, GETDATE()) BETWEEN 1 AND 2, 'Rango2M', 'NoRango2M') AS    Rango2M
		, (DATEDIFF(month, FechaCompleta, GETDATE()))								    AS    MesesAtras
		, (DATEDIFF(day, FechaCompleta, GETDATE()))								    AS    DiasAtras
		, (DATEDIFF(QUARTER, FechaCompleta, GETDATE()))								    AS    TrimestresAtras
		, (DATEDIFF(WEEK, FechaCompleta, GETDATE()))								    AS    SemanasAtras
		, (DATEDIFF(YEAR, FechaCompleta, GETDATE()))								    AS    AñosAtras
		, IIF(DATEDIFF(day, FechaCompleta, GETDATE()) BETWEEN 1 AND 30, 'Rango30D', 'NoRango30D') AS    Rango30D
		, IIF(DATEDIFF(day, FechaCompleta, GETDATE()) BETWEEN 1 AND 60, 'Rango60D', 'NoRango60D') AS    Rango60D
		, IIF(DATEDIFF(day, FechaCompleta, GETDATE()) BETWEEN 1 AND 90, 'Rango90D', 'NoRango90D') AS    Rango90D
		, IIF(DATEDIFF(day, FechaCompleta, DATEADD(DAY,7,EOMONTH(GETDATE()))) >=0, 'RangoHastaHoy7', 'NoRangoHastaHoy7') AS    RangoHastaHoy7
		, IIF(DATEDIFF(day, FechaCompleta, DATEADD(DAY,3,EOMONTH(GETDATE()))) >=0, 'RangoHastaHoy3', 'NoRangoHastaHoy3') AS    RangoHastaHoy3
		, IIF(idFecha = CONVERT(  INT, format(GETDATE(), 'yyyyMMdd')), 1, 0) AS                        Es_Hoy
		, IIF(Año=datepart(year,getdate()) and Mes=datepart(month,getdate()),1,0)				     Es_PeriodoActual
		, IIF(Año = DATEPART(year, GETDATE())
	   			AND trimestre = DATEPART(quarter, GETDATE())
			 , 1, 0) AS															     Es_Trimestre_Actual
		, IIF(Año=datepart(year,dateadd(day,-1,getdate())) and Mes=datepart(month,dateadd(day,-1,getdate()))
			 and Dia between 1 and datepart(day,dateadd(day,-1,getdate()))
			 			 ,1,0)				 										Es_PeriodoActualReportable
		, 1 AS                                                                                         NumDias
	     , iif(datediff(day,getdate(),FechaCompleta)>=0,1,0) Es_Futuro
	FROM dim_Fecha t1
GO
