SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 02/05/2020
-- Description: Generar Todos los Pedidos XML
-- Modificacion: 07/08/2020
--	   Metemos tambien los pedidos desde tablet
-- =============================================
CREATE PROCEDURE [dbo].[uspGenerarTodosPedidosXML]
AS
    BEGIN

	   -- Declare 
	   DECLARE 
			@codEmpresa INT
		   , @nomIPad    NVARCHAR(50)
		   , @codPedido  INT
		   , @codCliente NVARCHAR(20)
		   , @contador   INT
		   , @Titulo     VARCHAR(MAX)
		   , @html       NVARCHAR(MAX)
		   , @sql        NVARCHAR(MAX)

	   -- Inicializar variables
	   SELECT 
			@codEmpresa=2
	   SELECT 
			@contador=0

	   -- Recorrer todos los pedidos
	   WHILE 1 = 1
		  BEGIN

			 -- Recoger el pedido
			 SELECT TOP 1 
				   @codEmpresa=t1.codEmpresa
				 , @nomIPad=t1.nomIpad
				 , @codPedido=t1.codPedido
				 , @codCliente=t1.codCliente
			 FROM   sym_iPedidos AS t1
				   INNER JOIN sym_iClientes AS t2 -- Clientes existentes
					ON t1.codEmpresa = t2.codEmpresa
					   AND t1.codCliente = t2.codCliente
			 WHERE  t1.codEmpresa = @codEmpresa
				   AND CONCAT(t1.codEmpresa, '-', t1.nomIPad, '-', t1.codPedido) > CONCAT(@codEmpresa, '-', @nomIPad, '-', @codPedido)
				   AND t1.flaExpPedido = 0
				   AND t1.datEstadoPedido = 'Traspasar'
				   --AND t1.codOrigenVenta IN('0', '1')
				   --AND t1.codOrigenVenta='1' -- De momento solos los Web 07/08/2020
				   AND t1.codTipoVenta = 1 -- Pedido

			 ORDER BY 
					t1.codEmpresa
				   , t1.nomIPad
				   , t1.codPedido

			 -- Exit loop if no more customers
			 IF @@ROWCOUNT = 0
				BREAK;

			 -- Actualizar contador
			 SELECT 
				   @Contador=@Contador + 1

			 -- Generar el pedido XML
			 EXEC dbo.uspGenerarPedidoXML 
				 @codEmpresa, 
				 @nomIPad, 
				 @codPedido, 
				 @codCliente, 
				 @Salida=0
		  END

	   -- Notificar si hay pedidos procesados
	   IF @Contador > 0
		  BEGIN 
			 -- Titulo para el email
			 SELECT 
				   @Titulo=CONCAT('Traspasados ', @contador, ' pedidos desde Inacatalog')
			 SELECT 
				   @sql=CONCAT('SELECT FORMAT(GETDATE(),''dd/MM/yyyy HH:mm'') FechaHora, ', @contador, ' Pedidos,', '''Traspasados a SAP''', ' Observaciones')

			 -- Resultado de la consulta en html
			 EXEC spQueryToHtmlTable2 
				 @html=@html OUTPUT, 
				 @query=@sql
			 --, @orderBy = N'ORDER BY Id';
			 -- Notificar
			 EXEC uspNotificarEmail
			 --@recipients = 'AlertasAdmins@unitos.com;',
				 @recipients='Raquel.Arambarri@cafestemplo.es', 
				 @copy_recipients='Ramon.Villanueva@ucc-coffee.es;', 
				 @subject='Pedidos de Inacatalog traspasados a SAP', 
				 @body=@html, 
				 @LogoEmp=2, 
				 @Titulo=@Titulo, 
				 @Observaciones='Resumen del Traspaso de Pedidos de Inacatalog a SAP.', 
				 @Observaciones1=''
		  END

	   -- Comprobar precios a cero
	   SELECT 
			@Contador=COUNT(*)
	   FROM   aux.ComprobarPrecioCero
	   IF @Contador > 0
		  BEGIN
			 SELECT 
				   @Titulo='Control de lineas de pedido a cero desde Inacatalog'
			 SELECT 
				   @sql='SELECT * FROM aux.ComprobarPrecioCero'

			 -- Resultado de la consulta en html
			 EXEC spQueryToHtmlTable2 
				 @html=@html OUTPUT, 
				 @query=@sql, 
				 @orderBy=N'ORDER BY fecPedido DESC';
			 -- Notificar
			 EXEC uspNotificarEmail
			 --@recipients = 'AlertasAdmins@unitos.com;',
				 @recipients='Raquel.Arambarri@cafestemplo.es', 
				 @copy_recipients='Ramon.Villanueva@ucc-coffee.es;', 
				 @subject='Lineas de Pedidos de Inacatalog a precio cero', 
				 @body=@html, 
				 @LogoEmp=2, 
				 @Titulo=@Titulo, 
				 @Observaciones='Lineas de pedido en las que no se ha encontrado precio en Inacatalog y pasa a cero en SAP.', 
				 @Observaciones1=''
		  END

	   -- Comprobar el estado de los pedidos
	   EXEC dbo.uspB2BEstadosPedidos
    END
GO
