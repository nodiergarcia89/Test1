SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date:	15/02/2019
-- Description:	Coffee Tester Realizados
-- =============================================
CREATE PROCEDURE [dbo].[usprptCoffeeTesterRealizados] 
    @CodDelegacion int=209
    , @RangoDias int=15
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
		  select * from rpt.AgendaCoffeeTester
		  return
	   end

    -- Recuperar los datos de los clientes
    select *
	   , IIF(KilosCafeDesdeCambioMuelas >= @KgCambioMuelas, 'S', 'N') CambiarMuelasCafe
	   , IIF(KilosCafeDecafDesdeCambioMuelas >= @KgCambioMuelas, 'S', 'N') CambiarMuelasCafeDecaf
	   , IIF(KilosCafeDesdeCambioFiltro>0 and DiasDesdeCambioFiltro >= @CambioFiltro, 'S', 'N') CambiarFiltro
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
    from vrptAgendaVisitas
    where codDelegacion=@CodDelegacion
	   and RealizadoCoffeTester='S'
	   
END
GO
