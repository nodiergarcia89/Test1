SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[vstgfact_VisitasInacatalog] AS
SELECT t1.CodEmpresa
      ,t1.Clave IdRegistro
      ,t1.Dispositivo
      ,t1.codAgente
      ,t1.Reporte
	 ,t1.FechaVisita
      ,t1.Fecha_key
      ,t1.HoraDia
	 ,datepart(minute,t1.Hora) MinutoDia
      ,t1.Fotos
      ,t1.CodCliente
      ,t1.Planificada
      ,t1.PlanSigVisita
      ,t1.FecSigVisita
      ,t1.CodTipoVisita
      ,t1.TipoVisita
      ,t1.Accion
      ,t1.Observaciones
  FROM [SAP_STG].[dbo].[stgF3AnalisisVisitas] t1
  WHERE ISNUMERIC(t1.CodCliente)=1
GO
