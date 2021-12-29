SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date:	16/03/16
-- Description:	Vista de Stage para la Bridge_ContratosMaquinaria
-- ==================================================================
CREATE view [dbo].[vstgContratosMaquinaria] as
SELECT
	  CONVERT( INT, t1.VBELN)  NumContrato
	, convert(int,t1.MATNR)	  CodArticulo
	, iif(t1.N_SERIE<>'',t1.N_SERIE,'Pos:' + t1.POSNR)  NumEquipo
	, coalesce(t2.SERGE,'N/A') Matricula
	, t1.IMPORTE			  Importe
	, convert(int,t1.KUNNR)	  CodCliente
	, t1.COSTE_MAQ			  ImporteCoste
	, iif(t1.GASTO='X',1,0)	  Gasto
	, t1.COSTE			  CosteMaqProp
FROM   dbo.ZCAH006 AS t1
LEFT OUTER JOIN dbo.EQUI AS t2
    on t1.MANDT COLLATE DATABASE_DEFAULT=t2.MANDT
	   and t1.N_SERIE COLLATE DATABASE_DEFAULT=t2.EQUNR
WHERE t1.MODIF	 <>'X'


GO
