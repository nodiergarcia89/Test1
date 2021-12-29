SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vResumenVisitas] as
select codAgente
	, NombreCompleto
	, Delegacion
	, semana
	, count(distinct(iif(diasemana between 1 and 5, diasemanatxt, null))) diaslaborables
	, count(distinct(iif(diasemana in(6,7), diasemanatxt, null))) diasfestivos
	, sum(iif(diasemana between 1 and 5, 1,0)) laborables
	, sum(iif(diasemana in (6,7), 1,0)) as festivos
	, sum(iif(horadia not between 8 and 19, 1,0)) fuerahorario
	, sum(Planificada) Planificada
	, sum(plansigvisita) PlanSigVisita
	, sum(iif(fechavisita<=fecsigvisita, 1,0)) planificadaerr
    , count(distinct codcliente) Clientes
	, count(distinct tipovisita) TiposVisita
	, count(clave) Visitas
	, iif(count(clave)-count(distinct codcliente) >0,1,0) Revisitas
	
from stgF3AnalisisVisitas
group by codAgente, NombreCompleto,Delegacion, Semana




GO
