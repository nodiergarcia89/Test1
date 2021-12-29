SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date:	15/03/16
-- Description:	Vista de Stage para la Dim_Contratos
-- ==================================================================
CREATE view [dbo].[vstgF3Dim_Contratos] as
SELECT distinct
	 CodEmpresa
      ,convert(int,[VBELN])	  		NumContrato
      ,convert(int,[VKBUR])			CodDelegacion
      ,[TIPO]						CodTipoContrato
	 , case 
		  when TIPO='E' then 'EXPRESSO'
		  when TIPO='C' then 'CAPSULAS'
		  when TIPO='M' then 'MIXTO'
		  else 'N/A'
	    end TipoContrato
      ,[CLASE]						CodClaseContrato
      ,UPPER([CLASE_TXT])			ClaseContrato
      ,convert(int,[MATNR_NORM])		CodArticuloCafe
      ,convert(int,[MATNR_DESC])		CodArticuloDesc
FROM  stgF2CumpInversiones
GO
