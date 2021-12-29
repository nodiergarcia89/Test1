SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*-- =====================================================================
-- Author:	 Ramon Villanueva
-- Create date: 08/06/2020
-- Description: Notificar Pedido
--	   Estados de Pedidos:
		  --1.	Pedido registrado en la plataforma B2B
		  --2.	Pedido traspasado al MS
		  --3.	Pedido traspasado a SAP
		  --4.	Pedido generado en SAP
		  --5.	Pedido traspasado a la agencia de transporte
		  --6.	Pedido enviado al cliente por la agencia de transporte
		  --7.	Entregado. Albarán firmado por el cliente
		  --8.	Pedido Facturado
		  --9.	Pedido cancelado

08/02/2021 
Los pedidos se notifican segun el criterio:

		| WEB | SAP | OP.LOG | FACT | 
CLIENTE	|  X	 |	  |   X	 |	   |
RESP.CTA	|  X	 |	  |   X 	 |	   |
RAQUEL	|	 |  X  |	 	 |	   |

-- =====================================================================*/
CREATE   PROCEDURE [dbo].[uspNotificarPedido](
					 @codEmpresa INT         =2
				    , @nomIPad    NVARCHAR(50)='Web'
				    , @codPedido  INT         =782
				    , @Estado	   INT         =2
)
AS
    BEGIN

	   SET LANGUAGE SPANISH

	   -- Declarar variables
	   DECLARE @html NVARCHAR(MAX)
	   DECLARE @htmlCabecera NVARCHAR(MAX)
	   DECLARE @htmlLineas NVARCHAR(MAX)
	   DECLARE @Observaciones NVARCHAR(MAX)
	   DECLARE @subject NVARCHAR(MAX)
	   DECLARE @htmlTotal NVARCHAR(MAX)
	   DECLARE @Titulo VARCHAR(MAX)
	   DECLARE @sqlCabecera NVARCHAR(MAX)
	   DECLARE @sqlLineas NVARCHAR(MAX)
	   DECLARE @sqlTotal NVARCHAR(MAX)
	   DECLARE @sql NVARCHAR(MAX)
	   DECLARE @codCliente NVARCHAR(20)
	   DECLARE @recipients NVARCHAR(200)
	   DECLARE @EmailClte NVARCHAR(200)
	   DECLARE @NumLineas int
	   DECLARE @DesEstado NVARCHAR(60)
	   DECLARE @blind_copy_recipients NVARCHAR(MAX)
	   DECLARE @copy_recipients NVARCHAR(MAX)
	   DECLARE @NumPedidoSAP NVARCHAR(10)
	   DECLARE @FechaEntregaPrevista NVARCHAR(30)
	   DECLARE @NumAlbaran NVARCHAR(10)
	   DECLARE @NumFactura NVARCHAR(10)

	   -- Tabla Estados
	   DECLARE @Estados AS TABLE
	   (
	   CodEstado INT
	   , DesEstado NVARCHAR(60)
	   )

	   INSERT INTO @Estados
		  SELECT 1, 'Pedido registrado en la plataforma B2B'
		  UNION ALL
		  SELECT 2, 'Pedido traspasado al MS'
		  UNION ALL
		  SELECT 3, 'Pedido traspasado a SAP'
		  UNION ALL
		  SELECT 4, 'Pedido generado en SAP'
		  UNION ALL
		  SELECT 5, 'Pedido traspasado a la agencia de transporte'
		  UNION ALL
		  SELECT 6, 'Pedido enviado al cliente por la agencia de transporte'
		  UNION ALL
		  SELECT 7, 'Entregado. Albarán firmado por el cliente'
		  UNION ALL
		  SELECT 8, 'Pedido Facturado'
		  UNION ALL
		  SELECT 9, 'Pedido cancelado'

	   -- Numero de lineas del pedido
	   SELECT @NumLineas=COALESCE(COUNT(*),0)
	   FROM sym_iPedidosLin
	   WHERE codEmpresa = @CodEmpresa
		   AND nomIPad = @nomIPad
		   AND codPedido = @codPedido
	   
	   -- Estado del Pedido
--	   SELECT @DesEstado=IIF(@nomIPad='Web' and @Estado=1,DesEstado,'Pedido registrado en servidor Inacatalog')
	   SELECT @DesEstado=DesEstado
	   FROM @Estados
	   WHERE CodEstado=@Estado

	   -- Consulta a notificar (cabecera del Pedido)
	   SELECT 
			@sqlCabecera='SELECT 
				   t.codPedido AS						    Num
				 , t.nomIPad							    Origen
				 , t.CodCliente						    CodClte
				 , s.nomCliente						    [Cliente             ]
				 , UPPER(CONCAT(r.datCalleDirCli
								,". "
								,r.codPostalDirCli
								,", "
								,r.datPoblacionDirCli
								,". ("
								,r.datProvinciaDirCli
								,")"
								))					    [Direccion de Envío]
				 , FORMAT(t.fecPedido,"dd/MM/yyyy") AS           FecPedido
				 , t.datFechaEntrega AS					    FecEntrega
			 FROM   sym_ipedidos AS t
			 INNER JOIN sym_iClientes AS s
				on t.CodEmpresa=s.CodEmpresa
				    AND t.CodCliente=s.CodCliente
			 INNER JOIN sym_iClientesLDir AS r
				ON t.CodEmpresa=r.CodEmpresa
				    AND t.CodCliente=r.CodCLiente
				    AND t.linDirCli=r.linDirCli
			 WHERE  t.codEmpresa = <CodEmpresa>
				   AND t.nomIPad = "<nomIPad>"
				   AND t.codPedido = "<codPedido>"'

	   -- Realizar reemplazos
	   SELECT 
			@sqlCabecera=REPLACE(REPLACE(REPLACE(REPLACE(@sqlCabecera, '"', '''')
				    , '<codEmpresa>', @codEmpresa)
				    , '<nomIPad>', @nomIPad)
				    , '<codPedido>', @codPedido)

	   -- Resultado de la consulta en html
	   EXEC spQueryToHtmlTable2 
		   @html=@htmlCabecera OUTPUT, 
		   @query=@sqlCabecera
	   --, @orderBy = N'ORDER BY Id';

	
	   -- Consulta a notificar (Lineas del Pedido)
	   SELECT 
			@sqlLineas='SELECT 
							t2.codArticulo AS                         [Cod.]
						   , t2.desLinPed AS                           Articulo
						   , FORMAT(t2.canIndicada, "#,####.##") AS    [Cant.]
						   , t2.codMagnitud AS                         UM
						   , FORMAT(t2.preLinPed, "#,###0.##€;#;#") AS Precio
						   , FORMAT(t2.impNetoLinPed, "#,###0.##€;#;#") AS Importe
					   FROM   sym_iPedidosLin AS t2
					   WHERE  t2.codEmpresa = <CodEmpresa>
							 AND t2.nomIPad = "<nomIPad>"
							 AND t2.codPedido = "<codPedido>"'

	   -- Realizar reemplazos
	   SELECT 
			@sqlLineas=REPLACE(REPLACE(REPLACE(REPLACE(@sqlLineas, '"', '''')
				    , '<codEmpresa>', @codEmpresa)
				    , '<nomIPad>', @nomIPad)
				    , '<codPedido>', @codPedido)

	   -- Resultado de la consulta en html
	   EXEC spQueryToHtmlTable2 
		   @html=@htmlLineas OUTPUT, 
		   @query=@sqlLineas

	   -- Consulta a notificar (Total del Pedido)
	   SELECT 
			@sqlTotal='SELECT 
				   FORMAT(<NumLineas>,"#,####") AS			         NumLineas
				 , FORMAT(t.totNetoPed,"#,###0.##€;#;#") AS           TotalNeto
				 , FORMAT(t.totBaseImponiblePed,"#,###0.##€;#;#") AS  BaseImponible
				 , FORMAT(t.totIVAPed,"#,###0.##€;#;#") AS            IVA
				 , FORMAT(t.totREPed,"#,###0.##€;#;#") AS             RecEqui
				 , FORMAT(t.totPed,"#,###0.##€;#;#") AS               TotalPedido
				 , "<Estado>" AS						         Estado
			 FROM   sym_ipedidos AS t
			 WHERE  t.codEmpresa = <CodEmpresa>
				   AND t.nomIPad = "<nomIPad>"
				   AND t.codPedido = "<codPedido>"'

	   -- Realizar reemplazos
	   SELECT 
			@sqlTotal=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@sqlTotal, '"', '''')
				    , '<codEmpresa>', @codEmpresa)
				    , '<nomIPad>', @nomIPad)
				    , '<codPedido>', @codPedido)
				    , '<NumLineas>',@NumLineas)
				    , '<Estado>', @DesEstado)

	   -- Resultado de la consulta en html
	   EXEC spQueryToHtmlTable2 
		   @html=@htmlTotal OUTPUT, 
		   @query=@sqlTotal
	   --, @orderBy = N'ORDER BY Id';
	   
	   -- Juntar los dos resultados
	   SELECT @html=CONCAT(@htmlCabecera,'<br>',@htmlLineas,'<br><br>',@htmlTotal)

	   -- Recoger datos de estado del pedido
	   SELECT @NumPedidoSAP=coalesce(NumPedidoSAP,'')
			 ,@FechaEntregaPrevista=coalesce(FORMAT(CONVERT(date,FechaEntregaPrevista),'el dddd dd/MM/yyyy'),'')
			 ,@NumAlbaran=COALESCE(NumAlbaran,'')
			 ,@NumFactura=coalesce(NumFactura,'')
	   FROM TrackingPedidosLog
	   WHERE codEmpresa=@codEmpresa
		    AND nomIPad=@nomIPad
		    AND codPedido=@codPedido
		    AND estadoTracking=@Estado

	   -- Titulo para el email
	   SELECT 
			@Titulo=CONCAT('Pedido ', @codPedido , 
				CASE @Estado
				    WHEN 1 THEN ' recibido'
				    WHEN 2 THEN ' traspasado al MS'
				    WHEN 3 THEN ' generado en SAP'
				    WHEN 5 THEN ' enviado al Operador Logistico'
				    WHEN 8 THEN ' facturado'
				 END)

	   -- Recuperar Email del cliente
	   SELECT @EmailClte=t1.datEmailWeb
			 ,@CodCliente=CONVERT(NVARCHAR,t2.CodCliente)
	   FROM sym_iClientesMailB2B t1
	   INNER JOIN sym_iPedidos t2
		  ON t1.codEmpresa=t2.codEmpresa
			 AND t1.codCliente=t2.codCliente
	   WHERE t2.codEmpresa=@codEmpresa
		  AND t2.nomIPad=@nomIPad
		  AND t2.codPedido=@codPedido

	   -- Controlar que estados se notifican 
	   SELECT @copy_recipients=''
	   SELECT @recipients=(CASE
						  WHEN @Estado IN (2,5) THEN CONCAT(@EmailClte,';',COALESCE(aux.Udf_EmailResponsable(@CodCliente),''))
						  WHEN @Estado=3 THEN 'Raquel.Arambarri@cafestemplo.es'
				       END)

	   -- Con copia oculta a mi 
	   SELECT @blind_copy_recipients='Ramon.Villanueva@ucc-coffee.es'
	   SELECT @blind_copy_recipients=''

	   -- El asunto del email y las Observaciones van en funcion del estado a notificar
	   SELECT @Observaciones=
				(CASE @Estado
				    WHEN 2 THEN 'Hemos recibido su pedido, en breve recibirá otro email con los datos concretos de entrega.<br><br>Gracias por confiar en nosotros.'
				    WHEN 3 THEN CONCAT('El pedido ya se ha generado en SAP y se le ha asignado el numero ',@NumPedidoSAP)
				    WHEN 5 THEN CONCAT('El pedido ', @NumPedidoSAP, ' se ha enviado al Operador Logistico con el albaran numero ',@NumAlbaran,' y la fecha prevista de entrega es ',@FechaEntregaPrevista)
				    WHEN 8 THEN CONCAT('El pedido ',@NumPedidoSAP, ' con albaran numero ',@NumAlbaran,' se ha facturado en la factura numero ',@NumFactura)
				 END)
	   SELECT @subject=
				(CASE @Estado
				    WHEN 1 THEN 'Pedido Recibido'
				    WHEN 2 THEN 'Pedido traspasado al MS'
				    WHEN 3 THEN 'Pedido generado en SAP'
				    WHEN 5 THEN 'Pedido enviado al Operador Logistico'
				    WHEN 8 THEN 'Pedido Facturado'
				 END)

	   -- Notificar si procede
	   IF @recipients != '' OR @blind_copy_recipients != '' OR @copy_recipients != ''
		  EXEC uspNotificarEmail 
			  @recipients=@recipients,
			  --@recipients = 'Rebeca.Albarran@cafestemplo.es;Blanca.Herce@cafestemplo.es',
			  --@copy_recipients ='Javier.Chivite@cafestemplo.es;Alfonso.Area@ucc-coffee.es;Ramon.Villanueva@ucc-coffee.es;',
			  @blind_copy_recipients =@blind_copy_recipients,
			  @subject=@subject, 
			  @body=@html, 
			  @LogoEmp=2, 
			  @Titulo=@Titulo, 
			  @Observaciones=@Observaciones, 
			  @Observaciones1=''

	   -- Marcar el pedido como notificado
	   UPDATE TrackingPedidosLog
		  SET Notificado=1
			 , FechaNotificado=GETDATE()
			 , Email=CONCAT(@recipients, ' | ', @blind_copy_recipients)
	   WHERE codEmpresa=@codEmpresa
		  AND nomIPad=@nomIPad
		  AND codPedido=@codPedido
		  AND estadoTracking=@Estado
    END
GO
