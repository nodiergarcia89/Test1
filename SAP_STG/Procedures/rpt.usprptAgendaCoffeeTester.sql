SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================================
-- Author:		Ramon Villanueva
-- Create date:	09/02/2021
-- Description:	Agenda Coffee Tester. Listado
-- ===================================================================================
CREATE   PROCEDURE [rpt].[usprptAgendaCoffeeTester] 
					 @CodAgente INT
AS
    BEGIN

	   -- Declarar variables
	   DECLARE 
			@CodDelegacion SMALLINT
		   , @EsDelegado    INT;

	   -- Obtener delegacion y tipo de usuario
	   WITH Tabla
		   AS (SELECT 
				    t1.CodDelegacion
				  , t1.CodDelegado AS CodAgente
				  , t2.Delegado
			  FROM     inaDelegaciones AS t1
					 INNER JOIN dbo.stgF2Vendedores AS t2
					   ON t1.CodDelegado = t2.CodVendedor
			  WHERE   t1.Ina = 1
					AND t1.CodDelegado != 0
			  UNION ALL
			  SELECT 
				    t1.CodDelegacion
				  , t3.CodAgenteS
				  , t2.Delegado
			  FROM   inaDelegaciones AS t1
				    INNER JOIN dbo.stgF2Vendedores AS t2
					 ON t1.CodDelegado = t2.CodVendedor
				    LEFT JOIN dbo.inaAgentesSuperv AS t3
					 ON t3.CodAgente = t1.CodDelegado
			  WHERE  t1.Ina = 1
				    AND t1.CodDelegado != 0
				    AND t3.CodAgenteS IS NOT NULL)
		   SELECT 
				@CodDelegacion=t1.CodDelegacion
			   , @EsDelegado=t1.Delegado
		   FROM   Tabla AS t1
		   WHERE  t1.CodAgente = @CodAgente

	   -- Devolver datos
	   SELECT 
			t1.CodDelegacion
		   , t1.Delegacion
		   , t1.CodZonaVentas
		   , t1.ZonaVentas
		   , t1.ClasifABC
		   , t1.codTipoCliente
		   , t1.desTipoCliente
		   , t1.codCliente
		   , t1.nomCliente
		   , t1.codAgente
		   , t1.nomAgente
		   , t1.datCalleDirCli
		   , t1.codPostalDirCli
		   , t1.datPoblacionDirCli
		   , t1.datProvinciaDirCli
		   , t1.datContactoDirCli
		   , t1.Telefono
		   , t1.fecAltaCliente
		   , t1.Custom1
		   , t1.Custom2
		   , t1.Custom3
		   , t1.Custom4
		   , t1.Custom5
		   , t1.FechaProspeccion
		   , t1.codAgenteProspeccion
		   , t1.nomAgenteProspeccion
		   , t1.FechaPrimeraVisita
		   , t1.codAgentePrimeraVisita
		   , t1.nomAgentePrimeraVisita
		   , t1.FechaUltimaVisita
		   , t1.codAgenteUltimaVisita
		   , t1.nomAgenteUltimaVisita
		   , t1.FechaPrimerCoffeeTester
		   , t1.FechaUltimoCoffeeTester
		   , t1.CoffeeTesterRealizados
		   , t1.codAgenteUltimoCoffeeTester
		   , t1.nomAgenteUltimoCoffeeTester
		   , t1.RealizadoCoffeTester
		   , t1.DiasDesdeCoffeTester
		   , t1.Observaciones
		   , t1.FechaPlanifSigCT
		   , t1.FechaUltimoCambioFiltro
		   , t1.codAgenteCambioFiltros
		   , t1.nomAgenteCambioFiltros
		   , t1.RealizadoCambioFiltro
		   , t1.DiasDesdeCambioFiltro
		   , t1.FechaUltimoCambioMuelasCafe
		   , t1.codAgenteCambioMuelasCafe
		   , t1.nomCambioMuelasCafe
		   , t1.RealizadoCambioMuelasCafe
		   , t1.DiasDesdeCambioMuelasCafe
		   , t1.FechaUltimoCambioMuelasDecaf
		   , t1.codAgenteCambioMuelasDecaf
		   , t1.nomAgenteCambioMuelasDecaf
		   , t1.RealizadoCambioMuelasDecaf
		   , t1.DiasDesdeCambioMuelasDecaf
		   , t1.FechaUltCompraCafe
		   , t1.KilosCafeEntregadosT
		   , t1.KilosCafeEntregados
		   , t1.KilosCafeDecafEntregados
		   , t1.KilosCafeDesdeCambioMuelas
		   , t1.KilosCafeDecafDesdeCambioMuelas
		   , t1.KilosCafeDesdeCambioFiltro
		   , t1.KilosCafeDesdePrimerCoffeeTester
		   , t1.KilosCafeDecafDesdePrimerCoffeeTester
		   , t1.CambiarMuelasCafe
		   , t1.CambiarMuelasCafeDecaf
		   , t1.CambiarFiltro
		   , t1.AltaNueva
		   , t1.EnRangoDias
		   , t1.RangoDias
		   , t1.FechaSiguienteCoffeTester
		   , t1.CafeDesde2M
		   , t1.FotoUsuario
		   , t1.FechaRegistro
	   FROM   rpt.AgendaCoffeeTester AS t1
	   WHERE  t1.codAgente = @CodAgente
			OR t1.CodDelegacion = @CodDelegacion
			AND @EsDelegado = 1
    END
GO
