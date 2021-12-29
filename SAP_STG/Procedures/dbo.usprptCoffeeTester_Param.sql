SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 19/02/2020
-- Description:	Coffee Tester
-- Coffee Tester del reporte pasado por parametro
-- =============================================
CREATE PROCEDURE [dbo].[usprptCoffeeTester_Param] 
(@codEmpresa int
,@nomIPad nvarchar(50)
, @codReporte int)
AS
BEGIN

    -- Declarar variables
    declare @codCliente nvarchar(20)
    declare @FechaActivacion int
    declare @KilosCafeFacturados decimal(15,2)
    declare @KilosCafeDecafFacturados decimal(15,2)
    declare @KilosCafePdtes decimal(15,2)
    declare @KilosCafeDecafPdtes decimal(15,2)
    declare @KilosCafeConsumidos decimal(15,2)
    declare @KilosCafeDecafConsumidos decimal(15,2)
    declare @FechaUltimoCambioMuelasCafe nvarchar(8)
    declare @FechaUltimoCambioMuelasCafeDecaf nvarchar(8)
    declare @CambioMuelas bit=0
    declare @CambioMuelasDecaf bit=0
    declare @FechaReporte datetime
    
    -- Recuperar reporte realizado y no procesado de la tabla de log
    -- Uno cada vez
    SELECT TOP 1
		    @codCliente=t1.codCliente
		   ,@FechaReporte=t1.fecReporte
    FROM dbo.iReportesTriggerLog t1
    WHERE t1.CodEmpresa=@codEmpresa
	   AND t1.nomIPad=@nomIPad
	   AND t1.codReporte=@codReporte

    -- Fecha de activación del cliente	   
    SELECT @FechaActivacion=t1.FechaAltaComercial_key
    FROM   stgF3Clientes AS t1
    WHERE  t1.codEmpresa=@codEmpresa
	   and t1.CodCliente = @codCliente    
    	
    -- Ultimo cambio muelas cafe
    select t1.codCliente
	   ,CONVERT(nvarchar(8),fecReporte,112) FechaUltimoCambioMuelasCafe
	   ,ROW_NUMBER() OVER(PARTITION BY t1.codCliente ORDER BY fecReporte DESC) RowNum
    into #CambioMuelasCafe
    from [inaSAM].[dbo].[iReportes] t1
    inner join inaSAM.dbo.iReportesLin t3
	   on t1.codEmpresa=t3.codEmpresa
		  and t1.nomIPad=t3.nomIPad 
		  and t1.codReporte=t3.codReporte
		  and t3.linReportesLin=35 -- cambio muelas cafe 
		  and t3.datrespuesta=1
	 where t1.codempresa=@codEmpresa
		  and t1.CodCliente = @codCliente	
		  and t1.fecReporte < @FechaReporte
		  and t1.codPlantillaReportes IN('116','117')

    -- Ultimo cambio muelas descafeinado
    select t1.codCliente
	   ,CONVERT(nvarchar(8),fecReporte,112) FechaUltimoCambioMuelasDecaf
	   ,ROW_NUMBER() OVER(PARTITION BY t1.codCliente ORDER BY fecReporte DESC) RowNum
    into #CambioMuelasDecaf
    from [inaSAM].[dbo].[iReportes] t1
    inner join inaSAM.dbo.iReportesLin t3
	   on t1.codEmpresa=t3.codEmpresa
		  and t1.nomIPad=t3.nomIPad 
		  and t1.codReporte=t3.codReporte
		  and t3.linReportesLin=45 -- cambio muelas descafeinado
		  and t3.datrespuesta=1
	 where t1.codempresa=@codEmpresa
		  and t1.CodCliente = @codCliente	
		  and t1.fecReporte < @FechaReporte
		  and t1.codPlantillaReportes IN('116','117')

     -- Recoger valores
  	select @FechaUltimoCambioMuelasCafe=FechaUltimoCambioMuelasCafe
	from #CambioMuelasCafe 
	where RowNum=1
	-- Si no hay registros
	if @@ROWCOUNT = 0 
	   select @FechaUltimoCambioMuelasCafe=@FechaActivacion
     else 
	   select @CambioMuelas=1

  	select @FechaUltimoCambioMuelasCafeDecaf=FechaUltimoCambioMuelasDecaf
	from #CambioMuelasDecaf
	where RowNum=1
	-- Si no hay registros
	if @@ROWCOUNT = 0 
	   select @FechaUltimoCambioMuelasCafeDecaf=@FechaActivacion
     else 
	   select @CambioMuelasDecaf=1

    -- Kilos cafe entregados
    select  @KilosCafeFacturados=SUM(IIF(t1.FechaFactura<=@FechaUltimoCambioMuelasCafe,0,IIF(t2.Descaf='N',t1.KilosCafe,0)))
		 ,@KilosCafeDecafFacturados=SUM(IIF(t1.FechaFactura<=@FechaUltimoCambioMuelasCafe,0,IIF(t2.Descaf='S',t1.KilosCafe,0)))
    FROM dbo.stgF2FacturasVentasSAP as t1
	   inner join dbo.stgF2ArticulosSAP as t2
		  on t1.CodArticulo=t2.CodArticulo
			 and t2.CodEmpresa=@codEmpresa
			 and t2.CodTipoMaterial='Z001'
    WHERE  t1.CodCliente = @codCliente	 

    -- Kilos cafe pendientes
   select	  @KilosCafePdtes=SUM(IIF(t1.FechaAlbaran<=@FechaUltimoCambioMuelasCafeDecaf,0,IIF(t2.Descaf='N',t1.CantEntrega * t2.ConversionKG,0)))
		  , @KilosCafeDecafPdtes=SUM(IIF(t1.FechaAlbaran<=@FechaUltimoCambioMuelasCafeDecaf,0,IIF(t2.Descaf='S',t1.CantEntrega * t2.ConversionKG,0)))
    FROM dbo.stgAlbaranesPdtes as t1
	   INNER JOIN dbo.stgF2ArticulosSAP as t2
		  on t1.CodArticulo=t2.CodArticulo
			 and t2.CodEmpresa=@codEmpresa
			 and t2.CodTipoMaterial='Z001'
    WHERE  t1.CodCliente = @codCliente	 

    select @KilosCafeConsumidos=@KilosCafeFacturados + @KilosCafePdtes
    select @KilosCafeDecafConsumidos=@KilosCafeDecafFacturados + @KilosCafeDecafPdtes

    -- Devolver datos
    SELECT 
		 t1.CodEmpresa
	    , t1.nomIPad
	    , t1.codReporte
	    , t1.fecReporte
	    , t1.codPlantillaReportes
	    , t1.CodCliente
	    , t1.nomCliente
	    , t1.datCalleDirCli
	    , t1.codPostalDirCli
	    , t1.datPoblacionDirCli
	    , t1.datProvinciaDirCli
	    , t1.datContactoDirCli
	    , t1.datTelefonoDirCli
	    , t1.datTelMovilDirCli
	    , t1.datEmailDirCli
	    , t1.CodAgente
	    , t1.nomAgente
	    , t2.imgFoto FirmaCliente
	    , t3.imgFoto FirmaCoffeman
	    , IIF(ISDATE(@FechaActivacion)=0,null,convert (date, convert( nvarchar(8 ),@FechaActivacion), 112)) FechaActivacion
	    , @CambioMuelas CambioMuelas
	    , IIF(ISDATE(@FechaUltimoCambioMuelasCafe)=0,null,convert (date, convert( nvarchar(8 ),@FechaUltimoCambioMuelasCafe),112)) FechaUltimoCambioMuelasCafe
	    , @CambioMuelasDecaf CambioMuelasDecaf
	    , IIF(ISDATE(@FechaUltimoCambioMuelasCafeDecaf)=0,null,convert (date, convert( char(8 ),@FechaUltimoCambioMuelasCafeDecaf),112)) FechaUltimoCambioMuelasCafeDecaf
	    , @KilosCafeConsumidos KilosCafeConsumidos
	    , @KilosCafeDecafConsumidos KilosCafeDecafConsumidos
	    , t1.Clave
	    , t1.FechaRegistro
	    , t1.Procesado
	    , t1.FechaProceso
	    , t1.[001]
	    , t1.[002]
	    , t1.[003]
	    , t1.[004]
	    , t1.[005]
	    , t1.[006]
	    , t1.[007]
	    , t1.[008]
	    , t1.[009]
	    , t1.[010]
	    , t1.[011]
	    , t1.[012]
	    , t1.[013]
	    , t1.[014]
	    , t1.[015]
	    , t1.[016]
	    , t1.[017]
	    , t1.[018]
	    , t1.[019]
	    , t1.[020]
	    , t1.[021]
	    , t1.[022]
	    , t1.[023]
	    , t1.[024]
	    , t1.[025]
	    , IIF(t1.[024]=1,FORMAT(t1.fecReporte,'dd/MM/yyyy'),'') [026]
	    , IIF(t1.[024]=1,FORMAT(DATEADD(year,1,t1.fecReporte),'dd/MM/yyyy'),'') [027]
	    , t1.[028]
	    , t1.[029]
	    , t1.[030]
	    , t1.[031]
	    , t1.[032]
	    , t1.[033]
	    , t1.[034]
	    , t1.[035]
	    , t1.[036]
	    , t1.[037]
	    , t1.[038]
	    , t1.[039]
	    , t1.[040]
	    , t1.[041]
	    , t1.[042]
	    , t1.[043]
	    , t1.[044]
	    , t1.[045]
	    , t1.[046]
	    , t1.[047]
	    , t1.[048]
	    , t1.[049]
	    , t1.[050]
	    , t1.[051]
	    , t1.[052]
	    , t1.[053]
	    , t1.[054]
	    , t1.[055]
	    , t1.[056]
	    , t1.[057]
	    , t1.[058]
	    , t1.[059]
	    , t1.[060]
	    , t1.[061]
	    , t1.[062]
	    , t1.[063]
	    , t1.[064]
	    , t1.[065]
	    , t1.[066]
	    , t1.[068] -- Tipo de coffee tester (Programado/A Demanda)
    FROM   SAP_STG.dbo.iReportesTriggerLog AS t1
    LEFT JOIN inaSAM.dbo.iReportesLFotos AS t2 -- Firma del cliente
	   on t1.codEmpresa=t2.codEmpresa
		  and t1.nomIPad=t2.nomIPad
		  and t1.codReporte=t2.codReporte
		  and t1.[063]=t2.linReportesLFotos
    LEFT JOIN inaSAM.dbo.iReportesLFotos AS t3 -- Firma del coffeeman
	   on t1.codEmpresa=t3.codEmpresa
		  and t1.nomIPad=t3.nomIPad
		  and t1.codReporte=t3.codReporte
		  and t1.[064]=t3.linReportesLFotos
    WHERE  t1.codPlantillaReportes IN(116,117)
		  AND t1.codEmpresa=@codEmpresa
		  and t1.nomIPad=@nomIPad
		  and t1.codReporte=@codReporte


END
GO
