SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================
-- Author:		Ramon Villanueva
-- Create date: 11/01/2015
-- Description:	Traspaso tablas inaCatalog. Familias
-- Para generar las familias en parametros inaFamilias
-- ====================================================
CREATE VIEW [dbo].[vIna_iFamiliasF1] as
SELECT	
		 2 as CodEmpresa
		,convert(int,substring([JerarquiaSAP],1,2)) as codFamilia
		,0 as codSubFamilia
		,left([Nivel1],50) as desFamilia
		--,[CodNivel1] as ordFamilia
		,[JerarquiaSAP]
		,dbo.ProperCase(left([Nivel1],50)) NuevaDescripcion
		,0 Ina
  FROM [dbo].[vstgF2JerarquiaProductos]
  where CodNivel1<>3 and CodNivel2=0
UNION
SELECT	
		 2 as codEmpresa
		,convert(int,substring([JerarquiaSAP],1,2)) as codFamilia
		,convert(int,substring([JerarquiaSAP],3,2)) as codSubFamilia
		,left([Nivel2],50) as desFamilia
		--,[CodNivel2] as ordFamilia
		,[JerarquiaSAP]
		,dbo.ProperCase(left([Nivel2],50)) as NuevaDescripcion
		,0 Ina
	FROM [dbo].[vstgF2JerarquiaProductos]
  where CodNivel1<>3 and CodNivel2<>0 and CodNivel3=0
UNION
SELECT	
		 2 as codEmpresa
		,convert(int,substring([JerarquiaSAP],1,2)) as codFamilia
		,convert(int,substring([JerarquiaSAP],3,4)) as codSubFamilia
		,left([Nivel2] + '. ' + [Nivel3],50) as desFamilia
		--,[CodNivel2] as ordFamilia
		,[JerarquiaSAP]
		,dbo.ProperCase(left([Nivel2] + '. ' + [Nivel3],50)) as NuevaDescricion
		,0 Ina
  FROM [dbo].[vstgF2JerarquiaProductos]
  where CodNivel1<>3 and  CodNivel2<>0 and CodNivel3<>0 and CodNivel4=0
UNION
SELECT	
		2 as codEmpresa
		,convert(int,substring([JerarquiaSAP],1,2)) as codFamilia
		,convert(int,substring([JerarquiaSAP],3,6)) as codSubFamilia
		,left([Nivel2] + '. ' + [Nivel3] + '. ' + [Nivel4],50) as desFamilia
		--,[CodNivel2] as ordFamilia
		,[JerarquiaSAP]
		,dbo.ProperCase(left([Nivel2] + '. ' + [Nivel3] + '. ' + [Nivel4],50)) as NuevaDescripcion
		,0 Ina
FROM [dbo].[vstgF2JerarquiaProductos]
where CodNivel1<>3 and  CodNivel2<>0 and CodNivel3<>0 and CodNivel4<>0
-- La maquinaria CodNivel1=3 va distinto
UNION
SELECT	
		 2 as codEmpresa
		,29 + convert(int,substring([JerarquiaSAP],3,2)) as codFamilia
		,0 as codSubFamilia
		,left([Nivel2],50) as desFamilia
		--,[CodNivel2] as ordFamilia
		,[JerarquiaSAP]
		,dbo.ProperCase(left([Nivel2],50)) as NuevaDescripcion
		,0 Ina
	FROM [dbo].[vstgF2JerarquiaProductos]
  where CodNivel1=3 and CodNivel2<>0 and CodNivel3=0
UNION
SELECT	
		 2 as codEmpresa
		,29 + convert(int,substring([JerarquiaSAP],3,2))  as codFamilia
		,convert(int,substring([JerarquiaSAP],3,4)) as codSubFamilia
		,left([Nivel2] + '. ' + [Nivel3],50) as desFamilia
		--,[CodNivel2] as ordFamilia
		,[JerarquiaSAP]
		,dbo.ProperCase(left([Nivel2] + '. ' + [Nivel3],50)) as NuevaDescricion
		,0 Ina
  FROM [dbo].[vstgF2JerarquiaProductos]
  where CodNivel1=3 and  CodNivel2<>0 and CodNivel3<>0 and CodNivel4=0


GO
