SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================
-- Author:		Ramon Villanueva
-- Create date:	15/06/2016
-- Description:	Documentos adjuntos por contrato
-- ========================================================
CREATE view [dbo].[vstgF2DocsAdjContrato] as

select NumContrato
    , sum(NumAdjuntos) NumAdjuntos
    , max(FechaAdjunto) MaxFechaAdjunto
from
(
select convert(int,INSTID_A) NumContrato
	   , format(convert(date, stuff(stuff(stuff(UTCTIME, 9, 0, ' '), 12, 0, ':'), 15, 0, ':')),'yyyyMMdd') FechaAdjunto
	   , count(*) NumAdjuntos
from SRGBTBREL
group by INSTID_A
, format(convert(date, stuff(stuff(stuff(UTCTIME, 9, 0, ' '), 12, 0, ':'), 15, 0, ':')),'yyyyMMdd') 
) as tt
group by NumContrato
GO
