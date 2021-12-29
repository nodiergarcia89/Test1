SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 07/04/2020
-- Description:	Condiciones Cliente HTML
-- =============================================
CREATE   PROC [dbo].[uspCondicionesCliente_HTML] 
(
	-- Parameters for the function
	@CodCliente INT
   , @CodNivel1  SMALLINT
)
AS
BEGIN
	   -- Declare the return variable here
	   DECLARE @Result varchar(8000)=''
	   
	   -- Declarar tabla de salida
	   declare @t table(HTML nvarchar(MAX))

	   DECLARE 
		   @sql      NVARCHAR(MAX)
		 , @orderBy    NVARCHAR(MAX)
		 , @html       NVARCHAR(MAX)

	   -- Componer consulta SQL
	   SELECT @sql=
	   'SELECT RTRIM(CodArticulo) + ".-" + RTRIM(Articulo) Producto
		   , CASE
			    WHEN CondEsp = "N"
			    THEN "*"
			    ELSE ""
			END -- A tarifa *
			+ format(PrecioCliente, "#,##0.## €/", "es-ES") + RTRIM(Unidad_Medida) PrecioCliente
		   , CASE -- Promocion
			    WHEN Base <> 0
			    THEN format(Base, "#,###.##", "es-ES") + "+" + format(Regalo, "#,###.##", "es-ES")
			    ELSE ""
			END  Promocion
		   , CASE -- Importe en €
			    WHEN Importe <> 0
			    THEN format(Importe, "#,###.## €", "es-ES")
			    ELSE ""
			END Importe
	   FROM   stgF3CondicionesCliente AS t2
	   WHERE  t2.CodCliente = ' + CONVERT(NVARCHAR,@CodCliente)
		    + ' AND t2.CodNivel1 =' + CONVERT(NVARCHAR,@CodNivel1)

	   -- Realizar sustituciones
	   SELECT @sql=REPLACE(@sql,'"','''')

	   -- Llamar a store procedure que devuelve la consulta como tabla HTML
	   EXEC spQueryToHtmlTable2 @html = @html OUTPUT
			 ,@query = @sql
			 ,@orderBy=''
   
	-- Return the result
	INSERT INTO @t
	   VALUES(@html)

	select * from @t

END
GO
