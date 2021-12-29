SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
Procedure:          uspNotificarArticulosSI 
Create Date:        15/06/2020
Author:             Ramón Villanueva
Description:        Se notifica los articulos sin imagenes. B2B
Call by:            
                    
Affected table(s):  
                    
Used By:            
Parameter(s):       
                    
Usage:              EXEC uspNotificarArticulosSI_B2B
                      
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------

***************************************************************************************************/

CREATE PROCEDURE [aux].[uspNotificarArticulosSI_B2B]
AS
    BEGIN
	   -- SET NOCOUNT ON added to prevent extra result sets from
	   -- interfering with SELECT statements.
	   SET NOCOUNT ON;
	   DECLARE 
			@html NVARCHAR(MAX)
	   DECLARE 
			@Tiempo VARCHAR(10)
	   DECLARE 
			@Titulo VARCHAR(MAX)
	   DECLARE 
			@LogFile NVARCHAR(40)
	   DECLARE 
			@ArticulosSI NVARCHAR(10)
	   DECLARE 
			@ArticulosCI NVARCHAR(10)
	   DECLARE 
			@Articulos NVARCHAR(10)
	   DECLARE 
			@sql NVARCHAR(MAX)
	   DECLARE 
			@FechaProceso NVARCHAR(8)
	   DECLARE 
			@NumClientes INT

	   --  Fecha del Proceso para la clave
	   SELECT 
			@FechaProceso=FORMAT(GETDATE(), 'yyyyMMdd')

	   -- Borrar registros
	   DELETE FROM aux.ArticulosSinImagen
	   WHERE       
		    FechaProceso = @FechaProceso

	   -- Numero de Clientes en B2B
	   SELECT 
			@NumClientes=COUNT(*)
	   FROM   sym_par_inaClientes
	   WHERE  Ina = 1;

	   -- Obtener articulos sin imagen;
	   WITH Tabla
		   AS (SELECT DISTINCT 
				    t1.CodFamilia
				  , t3.desFamilia
				  , t1.CodSubFamilia
				  , t4.desFamilia AS                   desSubFamilia
				  , t1.codArticulo
				  , t1.desArticulo
				  , IIF(t2.linImgArt = 0
					   AND t2.flaHayImg = 0, 0, 1) AS ConImagen
			  FROM   inaSAM.dbo.V_Web_iArticulos_Perso AS t1
				    INNER JOIN sym_iArticulosLImg AS t2
					 ON t1.CodEmpresa = t2.codEmpresa
					    AND t1.CodArticulo = t2.codArticulo
				    --AND t2.linImgArt = 0
				    --AND t2.flaHayImg = 0
				    INNER JOIN inaSAM.dbo.V_Web_ifamilias AS t3
					 ON t1.codEmpresa = t3.codempresa
					    AND CONVERT(NVARCHAR, t1.CodCatalogo) = t3.CodCatalogo
					    AND t1.codFamilia = t3.codFamilia
					    AND t3.codSubFamilia = 0
				    INNER JOIN inaSAM.dbo.V_Web_ifamilias AS t4
					 ON t1.codEmpresa = t4.codempresa
					    AND CONVERT(NVARCHAR, t1.CodCatalogo) = t4.CodCatalogo
					    AND t1.codFamilia = t4.codFamilia
					    AND t1.codSubfamilia = t4.codSubFamilia
				    INNER JOIN sym_iArticulosLFamB2B AS t5
					 ON t1.codEmpresa = t5.codempresa
					    AND t1.codArticulo = t5.codArticulo
			  WHERE  t1.CodEmpresa = 2)
		   SELECT 
				*
		   INTO 
			   #Tabla
		   FROM   Tabla

	   -- Numero de Registros
	   SELECT 
			@ArticulosSI=SUM(IIF(ConImagen = 0, 1, 0))
		   , @ArticulosCI=SUM(IIF(ConImagen = 0, 0, 1))
		   , @Articulos=COUNT(*)
	   FROM   #Tabla

	   -- Articulos sin imagen
	   INSERT INTO aux.ArticulosSinImagen
	   SELECT 
			@FechaProceso AS FechaProceso
		   , codFamilia
		   , desFamilia
		   , codSubFamilia
		   , desSubFamilia
		   , codArticulo
		   , desArticulo
	   FROM   #Tabla
	   WHERE  ConImagen = 0

	   -- Dar formato a la tabla (no puede haber ORDER en el SQL)
	   TRUNCATE TABLE aux.ArticulosSinImagen$Changes
	   INSERT INTO aux.ArticulosSinImagen$Changes
	   SELECT 
			IIF(desFamilia = LAG(desFamilia, 1) OVER(
	   ORDER BY 
			  CodFamilia
			, CodSubFamilia
			, codArticulo), '''', UPPER(desFamilia)) AS  Familia
		   , IIF(desSubFamilia = LAG(desSubFamilia, 1) OVER(
	   ORDER BY 
			  CodFamilia
			, CodSubFamilia
			, codArticulo), '', UPPER(desSubFamilia)) AS SubFamilia
		   , codArticulo
		   , desArticulo
	   FROM   aux.ArticulosSinImagen
	   WHERE  FechaProceso = @FechaProceso
	   ORDER BY 
			  CodFamilia
			, CodSubFamilia
			, codArticulo

	   -- Consulta a notificar
	   SELECT 
			@sql='SELECT * FROM aux.ArticulosSinImagen$Changes'

	   -- Titulo para el email
	   SELECT 
			@Titulo=CONCAT('Hay ', @ArticulosSI, ' artículos en Inacatalog que aparecen en el B2B sin imagen, de un total de ', @Articulos, '. Estos artículos sin imagen se muestran a ', @NumClientes, ' clientes.')

	   -- Resultado de la consulta en html
	   EXEC spQueryToHtmlTable2 
		   @html=@html OUTPUT, 
		   @query=@sql
	   --, @orderBy = N'ORDER BY Id';
	   -- Notificar
	   EXEC uspNotificarEmail
	   --@recipients = 'AlertasAdmins@unitos.com;',
		   @recipients='Raquel.Arambarri@cafestemplo.es;Blanca.Herce@cafestemplo.es', 
		   @copy_recipients='Javier.Chivite@cafestemplo.es;Alfonso.Area@ucc-coffee.es;Ramon.Villanueva@ucc-coffee.es;', 
		   @subject='Articulos sin Imagen en Inacatalog B2B', 
		   @body=@html, 
		   @LogoEmp=2, 
		   @Titulo=@Titulo, 
		   @Observaciones='Se detallan los articulos que aparecen en el portal B2B pero no tienen imagen.<br>Este email se lanza desde el Traspaso de Inacatalog.', 
		   @Observaciones1='', 
		   @file_attachments=@LogFile
    END
GO
