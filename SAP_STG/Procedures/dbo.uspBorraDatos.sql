SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================================================
-- Author:		Ramon Villanueva
-- Create date: 26/05/2015
-- Description:	Borrar datos de un dispositivo
-- =================================================================================================
CREATE procedure [dbo].[uspBorraDatos]
	@ipad char(10)='ipad53' 
as

BEGIN
	--dbo.iPedidosLIva
	--iPedidosLin
	--iPedidos
	--iReportesLin
	--iReportes
	--iReportesLFotos (d:\catalogo\imagenes reportes ipad)
	--iActividad

	delete
	from sym_iReportesLFotos
	where nomIPad=@ipad

	delete
	from sym_iReportesLin
	where nomIPad=@ipad

	delete
	from sym_iReportes
	where nomIPad=@ipad

	delete
	from sym_iPedidosLIva
	where nomIPad=@ipad

	delete
	from sym_iPedidosLin
	where nomIPad=@ipad

	delete
	from sym_iPedidos
	where nomIPad=@ipad

	delete
	from sym_iActividad
	where nomIPad=@ipad

end
GO
