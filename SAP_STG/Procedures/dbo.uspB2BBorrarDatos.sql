SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================================================
-- Author:		Ramon Villanueva
-- Create date:	07/08/2020
-- Description:	Borrado de datos de pedidos web.
--  Según el parametro:
--	   0.- Todo
--	   1.- Sólo lo del cliente pasado por parametro
-- =================================================================================================
CREATE   PROCEDURE [dbo].[uspB2BBorrarDatos](
					 @Tipo       INT=0
				    , @CodCliente INT=0
)
AS
    BEGIN
	   DECLARE @CodEmpresa int=2

	   -- Si es para un cliente obtener los numero de pedidos Web
	   SELECT 
			codPedido
	   INTO 
		   #PedidosWebCliente
	   FROM   InaSAM..iPedidos
	   WHERE  nomIpad = 'Web'
			AND CodCliente = @CodCliente
	  
	   IF @Tipo = 0 -- Borrado Completo
		  BEGIN
			 DELETE FROM InaSAM..iPedidosPortesT
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 DELETE FROM InaSAM..iPedidosPortesAgencia
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 DELETE FROM InaSAM..iPedidosLIva
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 DELETE FROM InaSAM..iPedidosLin
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 DELETE FROM InaSAM..iPedidos
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 --Workflow:
			 DELETE FROM InaSAM..iPedidosEnRevisionLin
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 DELETE FROM InaSAM..iPedidosEnRevisionLIva
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
		  
			 DELETE FROM InaSAM..iPedidosEnRevision
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 DELETE FROM InaSAM..iPedidosEstadoEnvio
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa

			 --Tracking pedidos:
			 DELETE FROM InaSAM..iTrackingPedidos
    				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
		END
		ELSE -- Borrar sólo los del cliente
		  BEGIN
			 DELETE FROM InaSAM..iPedidosPortesT
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidosPortesAgencia
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidosLIva
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidosLin
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidos
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 --Workflow:
			 DELETE FROM InaSAM..iPedidosEnRevisionLin
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidosEnRevisionLIva
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidosEnRevision
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 DELETE FROM InaSAM..iPedidosEstadoEnvio
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)

			 --Tracking pedidos:
			 DELETE FROM InaSAM..iTrackingPedidos
				WHERE nomiPad = 'Web' AND CodEmpresa=@CodEmpresa
				  AND codPedido IN
					   (SELECT codPedido
						  FROM #PedidosWebCliente)
	   END
    END
GO
