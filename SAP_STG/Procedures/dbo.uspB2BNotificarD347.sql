SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*-- =====================================================================
-- Author:	 Ramon Villanueva
-- Create date: 08/04/2021
-- Description: Notificar D347. Clientes B2B

-- =====================================================================*/
CREATE     PROCEDURE [dbo].[uspB2BNotificarD347]
AS
    BEGIN

	   SET LANGUAGE SPANISH

	   -- Declarar variables
	   DECLARE @html NVARCHAR(MAX)
	   DECLARE @Observaciones NVARCHAR(MAX)
	   DECLARE @Observaciones1 NVARCHAR(MAX)
	   DECLARE @subject NVARCHAR(MAX)
	   DECLARE @Titulo VARCHAR(MAX)
	   DECLARE @sql NVARCHAR(MAX)
	   DECLARE @recipients NVARCHAR(200)
	   DECLARE @EmailClte NVARCHAR(200)
	   DECLARE @blind_copy_recipients NVARCHAR(MAX)
	   DECLARE @copy_recipients NVARCHAR(MAX)

	   -- Valores del proceso
	   DECLARE @codPagador INT         
			 , @nomCliente NVARCHAR(100)
			 , @Email	   NVARCHAR(50)
			 , @Año	   INT     
			 , @NumClientes INT
	   
	   -- Inicializar variables
	   SELECT @Año=YEAR(GETDATE()) - 1
	   -- Titulo para el email
	   SELECT @Titulo=CONCAT('Resumen de Facturación del ', @Año)	   
	   -- El asunto del email y las Observaciones fijas
    	   SELECT @subject=CONCAT('Resumen de Facturación del ', @Año, ' disponible en el portal B2B')
	   SELECT @Observaciones1='Este es un mensaje automático. Por favor no responda.'

	   -- Clientes a notificar
	   SELECT 
			t1.CodPagador
		   , t1.nomCliente
		   , t1.Email
		   , t1.Año
		   , SUM(t1.Importe) AS                Importe
		   , SUM(ImporteIVA) AS                ImporteIVA
		   , SUM(ImporteTotalConIVA) AS        ImporteTotalConIVA
		   , COUNT(DISTINCT t1.Num_Factura) AS NumFacturas
	   INTO #Clientes
	   FROM   rpt.v347ClientesB2B AS t1
	   WHERE  t1.Email IS NOT NULL
			AND t1.Año = @Año
	   GROUP BY 
			  t1.CodPagador
			, t1.nomCliente
			, t1.Email
			, t1.Año

	   -- Clientes a notificar
	   SELECT @NumClientes=COUNT(DISTINCT CodPagador) FROM #Clientes

	   -- Consulta a notificar (Clientes a Notificar)
	   SELECT @sql='SELECT  
					  CodPagador Pagador
					, nomCliente [Nombre del Cliente]
					, FORMAT(Importe, "#,###.00;-#,###.00;#") Importe
					, FORMAT(ImporteIVA, "#,###.00;-#,###.00;#") IVA
					, FORMAT(ImporteTotalConIVA, "#,###.00;-#,###.00;#") Total
					, FORMAT(NumFacturas , "#,###") Num
				FROM #Clientes'

	   -- Realizar reemplazos
	   SELECT @sql=REPLACE(@sql, '"', '''')

	   -- Resultado de la consulta en html
	   EXEC spQueryToHtmlTable2 
		   @html=@html OUTPUT, 
		   @query=@sql

	   -- Mensaje resumen
	   SELECT @Observaciones=CONCAT('La tabla siguiente contiene la relación de los ', @NumClientes, ' clientes del B2B a los que se notifica que en nuestro <a href="https://b2b.cafestemplo.es/">Portal B2B</a> tienen disponible el Resumen de Facturación del ', @Año)
	   SELECT @recipients='sandra.ariza@cafestemplo.es;Raquel.Arambarri@cafestemplo.es'
	   SELECT @copy_recipients ='Javier.Chivite@cafestemplo.es;Julian.Viruete@cafestemplo.es;jjcarro@cafestemplo.es;maldana@cafestemplo.es;'
    	   -- Con copia oculta a mi 
	   SELECT @blind_copy_recipients='Ramon.Villanueva@ucc-coffee.es'

	   -- Notificar resumen
	   EXEC uspNotificarEmail 
			 @recipients=@recipients,
			 @copy_recipients =@copy_recipients,
			 @blind_copy_recipients=@blind_copy_recipients, 
			 @subject=@subject, 
			 @body=@html, 
			 @LogoEmp=2, 
			 @Titulo=@Titulo, 
			 @Observaciones=@Observaciones, 
			 @Observaciones1=@Observaciones1

	   -- Recorrer todos los clientes
	   WHILE 1 = 1
		  BEGIN

			 -- Recoger el cliente
			 SELECT TOP 1 
				   @CodPagador=CodPagador
				 , @nomCliente=nomCliente
				 , @Email=Email
				 , @Año=Año
			 FROM   #Clientes

			 -- Exit loop if no more customers
			 IF @@ROWCOUNT = 0
				BREAK;

			 -- Recuperar Email del cliente
			 SELECT @EmailClte=@Email

			 -- Controlar a quien se notifica
			 SELECT @recipients=@EmailClte

			 -- El asunto del email y las Observaciones
			 SELECT @Observaciones=CONCAT(@nomCliente, '. Le informamos que en nuestro <a href="https://b2b.cafestemplo.es/">Portal B2B</a> tiene disponible el Resumen de Facturación del ', @Año, '.<br><br>Gracias por confiar en nosotros.')

			 -- Notificar
			 EXEC uspNotificarEmail 
				 @recipients=@recipients,
				 --@copy_recipients ='Javier.Chivite@cafestemplo.es;Alfonso.Area@ucc-coffee.es;Ramon.Villanueva@ucc-coffee.es;',
				 --@blind_copy_recipients=@blind_copy_recipients, 
				 @subject=@subject, 
				 --@body=@html, 
				 @body='', 
				 @LogoEmp=2, 
				 @Titulo=@Titulo, 
				 @Observaciones=@Observaciones, 
				 @Observaciones1=@Observaciones1

			 -- Borrar el cliente procesado
			 DELETE #Clientes
			 WHERE CodPagador=@CodPagador
				AND	Año=@Año
		  END
    END
GO
