SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vDebug_Clientes] as

select coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) as CodDelegacion,
		t1.KUNNR CodCliente, t1.NAME1 Cliente, t1.ORT01 Poblacion, t1.PSTLZ CP, t1.REGIO CodProvincia, t1.STRAS Direccion, 'SIN NOMBRE' TipoError
from kna1 t1
LEFT OUTER JOIN KNVV as t1a -- Datos de Ventas
			ON	t1.MANDT=t1a.MANDT
				and t1.KUNNR=t1a.KUNNR 
where name1='' and name2=''
union all
select coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) as CodDelegacion,
		t1.KUNNR, t1.NAME1, t1.ORT01, t1.PSTLZ, t1.REGIO, t1.STRAS, 'SIN DIRECCION' TipoError
from kna1 t1
LEFT OUTER JOIN KNVV as t1a -- Datos de Ventas
			ON	t1.MANDT=t1a.MANDT
				and t1.KUNNR=t1a.KUNNR 
where stras=''
union all
select coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) as CodDelegacion,
		t1.KUNNR, t1.NAME1, t1.ORT01, t1.PSTLZ, t1.REGIO, t1.STRAS, 'SIN POBLACION' TipoError
from kna1 t1
LEFT OUTER JOIN KNVV as t1a -- Datos de Ventas
			ON	t1.MANDT=t1a.MANDT
				and t1.KUNNR=t1a.KUNNR 
where ORT01=''
union all
select coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) as CodDelegacion,
		t1.KUNNR, t1.NAME1, t1.ORT01, t1.PSTLZ, t1.REGIO, t1.STRAS, 'SIN COD.POSTAL' TipoError
from kna1 t1
LEFT OUTER JOIN KNVV as t1a -- Datos de Ventas
			ON	t1.MANDT=t1a.MANDT
				and t1.KUNNR=t1a.KUNNR 
where PSTLZ=''
union all
select coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) as CodDelegacion,
		t1.KUNNR, t1.NAME1, t1.ORT01, t1.PSTLZ, t1.REGIO, t1.STRAS, 'SIN PROVINCIA' TipoError
from kna1 t1
LEFT OUTER JOIN KNVV as t1a -- Datos de Ventas
			ON	t1.MANDT=t1a.MANDT
				and t1.KUNNR=t1a.KUNNR 
where REGIO=''
GO
