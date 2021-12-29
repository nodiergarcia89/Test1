SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================================
-- Author:		Ramon Villanueva
-- Create date:	21/01/2019
-- Description:	Agenda Coffee Tester
-- Modificacion:	27/04/2020
--    CambiarMuelasCafe: SI KilosCafeDesdeCambioMuelas >= @KgCambioMuelas
--					   OR KilosCafeEntregados >0
--						  AND RealizadoCambioMuelasCafe='N'
--    CambiarMuelasCafeDecaf: SI KilosCafeDecafDesdeCambioMuelas >= @KgCambioMuelas
--					   OR KilosCafeDecafEntregados >0
--						  AND RealizadoCambioMuelasDecaf='N'
--	 CambiarFiltro: SI KilosCafeDesdeCambioFiltro>0 and DiasDesdeCambioFiltro >= @CambioFiltro
--				    OR KilosCafeEntregadosT >0 
--					   AND RealizadoCambioFiltro='N'
-- ===================================================================================
CREATE   PROCEDURE [dbo].[usprptAgendaCoffeeTester_OLD] 
    @CodDelegacion int=209
    , @RangoDias int=365
    , @Test int=0
AS
BEGIN

    -- Declarar variables
    declare @ClientesADias int=60
    declare @ClientesBDias int=120
    declare @ClientesCDias int=365
    declare @KgCambioMuelas int=450
    declare @CambioFiltro int=365

    if @Test=1 -- En depuracion cojo los datos de la tabla temporal
	   begin
		  select * from tmp_AgendaVisitas
		  return
	   end

    -- Recuperar los datos de los clientes
    select *
	   --, IIF(KilosCafeDesdeCambioMuelas >= @KgCambioMuelas, 'S', 'N') CambiarMuelasCafe
	   --, IIF(KilosCafeDecafDesdeCambioMuelas >= @KgCambioMuelas, 'S', 'N') CambiarMuelasCafeDecaf
	   --, IIF(KilosCafeDesdeCambioFiltro>0 and DiasDesdeCambioFiltro >= @CambioFiltro, 'S', 'N') CambiarFiltro
	   , IIF((KilosCafeDesdeCambioMuelas >= @KgCambioMuelas) OR (KilosCafeEntregados >0 AND RealizadoCambioMuelasCafe='N'), 'S', 'N') CambiarMuelasCafe
	   , IIF((KilosCafeDecafDesdeCambioMuelas >= @KgCambioMuelas) OR (KilosCafeDecafEntregados >0 AND RealizadoCambioMuelasDecaf='N'), 'S', 'N') CambiarMuelasCafeDecaf
	   , IIF((KilosCafeDesdeCambioFiltro>0 and DiasDesdeCambioFiltro >= @CambioFiltro) OR (KilosCafeEntregadosT >0 AND RealizadoCambioFiltro='N'), 'S', 'N') CambiarFiltro
	   , IIF(DATEDIFF(day
			 ,fecAltaCliente
			 ,getdate()) <= 365 and FechaUltimoCoffeeTester = 0 
			 , 'S','N') AltaNueva 
	   , IIF(DATEDIFF(day
	  		 ,getdate()
			 ,DATEADD(day,(CASE ClasifABC 
						  WHEN 'A' THEN @ClientesADias
						  WHEN 'B' THEN @ClientesBDias
						  WHEN 'C' THEN @ClientesCDias
						END), FechaUltimoCoffeeTester))
		  <=@RangoDias, 'S', 'N') EnRangoDias
	   , DATEDIFF(day
	  		 ,getdate()
			 ,DATEADD(day,(CASE ClasifABC 
						  WHEN 'A' THEN @ClientesADias
						  WHEN 'B' THEN @ClientesBDias
						  WHEN 'C' THEN @ClientesCDias
						END), FechaUltimoCoffeeTester)
		  ) RangoDias
	   , IIF(FechaPlanifSigCT <>'', FechaPlanifSigCT,
		  DATEADD(day,(CASE ClasifABC 
						  WHEN 'A' THEN @ClientesADias
						  WHEN 'B' THEN @ClientesBDias
						  WHEN 'C' THEN @ClientesCDias
						END), FechaUltimoCoffeeTester) 
		  ) FechaSiguienteCoffeTester
	   , IIF(DATEDIFF(month, FechaUltCompraCafe,GETDATE())>2, 'S','N') CafeDesde2M
        ,'file://SVVM04/ImgIna$/' + IIF(CodDelegacion=209,'298','340') + '.jpg' as FotoUsuario

    from vrptAgendaVisitas 
    where codDelegacion=@CodDelegacion
	   and DiasDesdeCoffeTester >= (CASE ClasifABC 
								WHEN 'A' THEN @ClientesADias
								WHEN 'B' THEN @ClientesBDias
								WHEN 'C' THEN @ClientesCDias
							  END) - 30 -- Para que salgan con 30 dias de antelación
END
GO
