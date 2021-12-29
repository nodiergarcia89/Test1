SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO





-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 23/12/2014
-- Description:	Traspaso tablas inaCatalog. iFormasPago
-- Pagina 14
-- ======================================================
CREATE view [dbo].[vIna_iFormasPago] as
select CodEmpresa
		, ZTERM as CodFormaPago
		, TEXT1 as FormaPago
from T052U as t25 -- Forma de Pago
where	t25.MANDT=100
		and t25.ZTAGG=0
union all
select 2, 'XX', 'NO APLICABLE'


GO
