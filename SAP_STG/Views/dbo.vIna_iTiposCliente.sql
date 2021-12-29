SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO






-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 22/12/2014
-- Description:	Traspaso tablas inaCatalog. iTiposCliente
-- Pagina 15
-- ======================================================
CREATE view [dbo].[vIna_iTiposCliente] as
--select CodEmpresa	
--		,KDGRP CodTipoCliente
--		,KTEXT TipoCliente
--from T151T -- Tipo de cliente
--where MANDT=100
select  2 CodEmpresa
		, CodTipoCliente
		, TipoCliente
from inaTiposCliente
union all
select 2, 'XX', 'NO APLICABLE'



GO
