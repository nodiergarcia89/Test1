SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 11/03/2016
-- Description:	Bajas y Bloqueos
--   Con RowNum=1 nos quedamos con la ultima accion del
--   dia sobre el cliente.
-- ========================================================
CREATE view [dbo].[vstgF2BajasBloqueos] as
SELECT t1.CodEmpresa
	 ,1 CodCanal
      ,convert(int,t1.OBJECTID) CodCliente
      ,t1.USERNAME IdUserSAP
      ,t1.UDATE FechaProceso_key
	 , Substring(convert(char(6), t1.UTIME),1,2) + Substring(convert(char(6), t1.UTIME),3,2) + '00' HoraProceso_key
	 , CASE t1.FNAME   
		  WHEN 'AUFSD' THEN	
			 iif(t1.VALUE_NEW='01', 1, 2)
		  WHEN 'ZZFECHBAJ' THEN
			 iif(t1.VALUE_NEW='00000000', 3, 4)
		  ELSE	0
	  END CodAccion
	 , CASE t1.FNAME   
		  WHEN 'AUFSD' THEN	
			 iif(t1.VALUE_NEW='01', 'BLOQUEO', 'DESBLOQUEO')
		  WHEN 'ZZFECHBAJ' THEN
			 iif(t1.VALUE_NEW='00000000','REACTIVACION','BAJA')
		  ELSE	'N/A'
	  END Accion
	 , CASE t1.FNAME   
		  WHEN 'AUFSD' THEN	t1.UDATE	   
		  WHEN 'ZZFECHBAJ' THEN
			 iif(t1.VALUE_NEW='00000000',t1.UDATE,t1.VALUE_NEW)
	  END FechaAccion_key
	 , convert(datetime,
			 Substring(convert(char(8), t1.UDATE),1,4) + '-'
			 + Substring(convert(char(8), t1.UDATE),5,2) + '-'
			 + Substring(convert(char(8), t1.UDATE),7,2) + ' '
			 + Substring(convert(char(6), t1.UTIME),1,2) + ':'
			 + Substring(convert(char(6), t1.UTIME),3,2) + ':'
			 + Substring(convert(char(6), t1.UTIME),5,2)
			 , 120) FechaProceso_timestamp
      , ROW_NUMBER() OVER(PARTITION BY t1.OBJECTID, t1.UDATE
				      ORDER BY	t1.UTIME desc) RowNum
  FROM ZCDCAMBIOS t1
  WHERE t1.OBJECTCLAS='DEBI'
    --AND t1.TABNAME IN('KNA1', 'KNVV')
    AND t1.FNAME IN('AUFSD', 'ZZFECHBAJ')
    --AND t1.TCODE IN('VD05', 'ZSD022','XD02')
    
 

 
GO
