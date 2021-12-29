SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


/***************************************************************************************************
Procedure:          uspNotificarArticulosSI 
Create Date:        09/04/2020
Author:             Ramón Villanueva
Description:        Se notifica los articulos sin imagenes
Call by:            
                    
Affected table(s):  
                    
Used By:            
Parameter(s):       
                    
Usage:              EXEC uspNotificarArticulosSI
                      
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------

***************************************************************************************************/
CREATE   PROCEDURE [aux].[uspNotificarArticulosSI] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @html nvarchar(MAX)
    DECLARE @Tiempo varchar(10)
    DECLARE @Titulo varchar(MAX)
    DECLARE @LogFile nvarchar(40)

    declare @ArticulosSI NVARCHAR(10)
    declare @sql NVARCHAR(MAX)
    declare @FechaProceso NVARCHAR(8)

    --  Fecha del Proceso para la clave
    SELECT @FechaProceso=FORMAT(GETDATE(),'yyyyMMdd')

    -- Borrar registros
    DELETE
    FROM aux.ArticulosSinImagen
    WHERE FechaProceso=@FechaProceso

    -- Obtener articulos sin imagen
    ;WITH Tabla AS
    (
    SELECT DISTINCT
		 t1.CodFamilia
	    , t3.desFamilia
	    , t1.CodSubFamilia
	    , t4.desFamilia AS desSubFamilia
	    , t1.codArticulo
	    , t1.desArticulo
    FROM   sym_iArticulos AS t1
		 INNER JOIN sym_iArticulosLImg AS t2 
		   ON t1.CodEmpresa = t2.codEmpresa
			 AND t1.CodArticulo = t2.codArticulo
			 AND t2.linImgArt=0
			 AND t2.flaHayImg = 0
		 INNER JOIN sym_iFamilias AS t3
		   ON t1.codEmpresa = t3.codempresa
			 AND t1.CodCatalogo=t3.CodCatalogo
			 AND t1.codFamilia = t3.codFamilia
			 AND t3.codSubFamilia = 0
		 INNER JOIN sym_iFamilias AS t4
		   ON t1.codEmpresa = t4.codempresa
			 AND t1.CodCatalogo=t4.CodCatalogo
			 AND t1.codFamilia = t4.codFamilia
			 AND t1.codSubfamilia = t4.codSubFamilia
    WHERE  t1.CodEmpresa = 2
		 AND t1.codCatalogo = 2100
    )
    INSERT INTO aux.ArticulosSinImagen 
    SELECT @FechaProceso FechaProceso
         , codFamilia
	    , desFamilia
	    , codSubFamilia
	    , desSubFamilia
	    , codArticulo
	    , desArticulo
    FROM Tabla

    -- Dar formato a la tabla (no puede habere ORDER en el SQL)
    TRUNCATE TABLE aux.ArticulosSinImagen$Changes
   
   INSERT INTO aux.ArticulosSinImagen$Changes 
   SELECT 
		 IIF(desFamilia=LAG(desFamilia, 1)  OVER (ORDER BY CodFamilia, CodSubFamilia, codArticulo),'''',UPPER(desFamilia))  Familia
	    , IIF(desSubFamilia=LAG(desSubFamilia, 1)  OVER (ORDER BY CodFamilia, CodSubFamilia, codArticulo),'',UPPER(desSubFamilia))  SubFamilia
	    , codArticulo
	    , desArticulo
    FROM aux.ArticulosSinImagen
        WHERE FechaProceso=@FechaProceso
    ORDER BY CodFamilia
	    , CodSubFamilia
	    , codArticulo

    -- Consulta a notificar
    SELECT @sql='SELECT * FROM aux.ArticulosSinImagen$Changes'
  
    -- Numero de Registros
    SELECT @ArticulosSI=COUNT(*) FROM aux.ArticulosSinImagen$Changes 
        
    -- Titulo para el email
    SELECT @Titulo='Hay ' + @ArticulosSI + ' artículos en Inacatalog sin imagen'

    -- Resultado de la consulta en html
    EXEC spQueryToHtmlTable2 @html = @html OUTPUT
	   ,@query = @sql
    --, @orderBy = N'ORDER BY Id';

    -- Notificar
    EXEC [uspNotificarEmail]
	   --@recipients = 'AlertasAdmins@unitos.com;',
	   @recipients = 'Rebeca.Albarran@cafestemplo.es;Blanca.Herce@cafestemplo.es',
	   @copy_recipients ='Javier.Chivite@cafestemplo.es;Alfonso.Area@ucc-coffee.es;Ramon.Villanueva@ucc-coffee.es;',
	   @subject = 'Articulos sin Imagen en Inacatalog',
	   @body = @html,
	   @LogoEmp=2,
	  @Titulo=@Titulo,
	  @Observaciones='Se detallan los articulos que estan en las tablets pero no tienen imagen.<br>Este email se lanza desde el Traspaso de Inacatalog.',
	  @Observaciones1='',
	  @file_attachments=@LogFile
    

END
GO
