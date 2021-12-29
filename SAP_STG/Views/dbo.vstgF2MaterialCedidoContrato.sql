SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 25/03/2015
-- Description:	Material cedido por contrato
-- ========================================================
CREATE view [dbo].[vstgF2MaterialCedidoContrato] as
select	t1.VBELN NumContrato
		, t1.KUNNR CodCliente
		, t1.MATNR CodArticulo
		, t2.MAKTX Articulo
		, t1.N_SERIE NumEquipo
		, t1.SERGE NumSerieFab
		, t1.CHARG Lote
		, t1.CANTIDAD Cantidad
		, t1.IMPORTE Importe
		, t1.COSTE_MAQ Coste
		, case t1.MODIF when 'X' then 'S' else 'N' end Modificado
		, case t1.BORRADO when 'X' then 'S' else 'N' end Borrado
		, t1.FECHA_MOD FechaModificacion
from ZCAH006 t1
	inner join MAKT t2
		on t1.MANDT=t2.MANDT COLLATE DATABASE_DEFAULT
			and t1.MATNR=t2.MATNR COLLATE DATABASE_DEFAULT

GO
