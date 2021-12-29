SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================
-- Author:		Ramon Villanueva
-- Create date: 21/12/2018
-- Description:	Devolver reporte en un registro
-- En este sp se devuelve en un unico registro el reporte realizado por el usuario
-- ====================================================================================
CREATE PROCEDURE [dbo].[usp_inaReporteRegistro] 
( @codEmpresa AS int=2
 ,@codReporte as int=772
 ,@nomIPad as nvarchar(50)='ipad836')
AS
BEGIN
	SET NOCOUNT ON;

	SET LANGUAGE spanish

    ;WITH Tabla AS
    (
    SELECT 
		 ir.codEmpresa
	    , ir.nomIPad
	    , ir.codReporte
	    , ir.fecReporte
	    , ir.desReporte
	    , ir.codPlantillaReportes
	    , ir.codCliente
	    , ir.codAgente
	    , ir.codTipoPlantilla
	    , irl.linReportesLin
	    , irl.desCampo
	    , irl.codTipoCampo
	    , irl.flaObligado
	    , irl.datRespuesta
    FROM   inaSAM.dbo.iReportes AS ir
		 INNER JOIN inaSAM.dbo.iReportesLin AS irl
		   ON ir.codEmpresa = irl.codEmpresa
			 AND ir.nomIPad = irl.nomIPad
			 AND ir.codReporte = irl.codReporte
    WHERE  ir.codEmpresa = @codEmpresa
		 AND ir.codreporte = @codReporte
		 AND ir.nomIPad = @nomIPad
    )
    , PivotTable AS
    (
    select Clave, [001],[002],[003],[004],[005],[006],[007],[008],[009],[010],[011],[012],[013],[014],[015],[016],[017],[018],[019],[020],[021],[022],[023],[024],[025],[026],[027],[028],[029],[030],[031],[032],[033],[034],[035],[036],
		    [037],[038],[039],[040],[041],[042],[043],[044],[045],[046],[047],[048],[049],[050],[051],[052],[053],[054],[055],[056],[057],[058],[059],[060],[061],[062],[063],[064],[065],[066],[067],[068],[069],[070],[071],[072],
		    [073],[074],[075],[076],[077],[078],[079],[080],[081],[082],[083],[084],[085],[086],[087],[088],[089],[090],[091],[092],[093],[094],[095],[096],[097],[098],[099],[100],[101],[102],[103],[104],[105],[106],[107],[108],
		    [109],[110],[111],[112],[113],[114],[115],[116],[117],[118],[119],[120],[121],[122],[123],[124],[125],[126],[127],[128],[129],[130],[131],[132],[133],[134],[135],[136],[137],[138],[139],[140],[141],[142],[143],[144],
		    [145],[146],[147],[148],[149],[150]
	    --into #tmp_lin
	    FROM
	    (select cast(L.codEmpresa as varchar) + '-'+ L.nomiPad+ '-'+ cast(L.codReporte as varchar) as Clave, 
	    L.linReportesLin, L.datRespuesta 
	    from Tabla L) as pvt 
	    pivot (MAX(datRespuesta) FOR linReportesLin IN	
		    ([001],[002],[003],[004],[005],[006],[007],[008],[009],[010],[011],[012],[013],[014],[015],[016],[017],[018],[019],[020],[021],[022],[023],[024],[025],[026],[027],[028],[029],[030],[031],[032],[033],[034],[035],[036],
		    [037],[038],[039],[040],[041],[042],[043],[044],[045],[046],[047],[048],[049],[050],[051],[052],[053],[054],[055],[056],[057],[058],[059],[060],[061],[062],[063],[064],[065],[066],[067],[068],[069],[070],[071],[072],
		    [073],[074],[075],[076],[077],[078],[079],[080],[081],[082],[083],[084],[085],[086],[087],[088],[089],[090],[091],[092],[093],[094],[095],[096],[097],[098],[099],[100],[101],[102],[103],[104],[105],[106],[107],[108],
		    [109],[110],[111],[112],[113],[114],[115],[116],[117],[118],[119],[120],[121],[122],[123],[124],[125],[126],[127],[128],[129],[130],[131],[132],[133],[134],[135],[136],[137],[138],[139],[140],[141],[142],[143],[144],
		    [145],[146],[147],[148],[149],[150])
		    ) as C
    )
    -- Devolver registros
    SELECT @codEmpresa CodEmpresa
		  ,@nomIPad nomIPad
		  ,@codReporte CodReporte
		  , t2.fecReporte
		  , t2.codPlantillaReportes
		  , t2.codCliente
		  , t3.nomCliente
    		  , t5.datCalleDirCli
		  , t5.codPostalDirCli
		  , t5.datPoblacionDirCli
		  , t5.datProvinciaDirCli
		  , t5.datContactoDirCli
		  , t5.datTelefonoDirCli
		  , t5.datTelMovilDirCli
		  , t5.datEmailDirCli
		  , t2.CodAgente
		  , t4.nomAgente
		  , t2.CodArticulo
		  , t1.Clave
		  , getdate() FechaRegistro
		  , 0 Procesado
		  , null FechaProceso
		  ,[001],[002],[003],[004],[005],[006],[007],[008],[009],[010],[011],[012],[013],[014],[015],[016],[017],[018],[019],[020],[021],[022],[023],[024],[025],[026],[027],[028],[029],[030],[031],[032],[033],[034],[035],[036],
		    [037],[038],[039],[040],[041],[042],[043],[044],[045],[046],[047],[048],[049],[050],[051],[052],[053],[054],[055],[056],[057],[058],[059],[060],[061],[062],[063],[064],[065],[066],[067],[068],[069],[070],[071],[072],
		    [073],[074],[075],[076],[077],[078],[079],[080],[081],[082],[083],[084],[085],[086],[087],[088],[089],[090],[091],[092],[093],[094],[095],[096],[097],[098],[099],[100],[101],[102],[103],[104],[105],[106],[107],[108],
		    [109],[110],[111],[112],[113],[114],[115],[116],[117],[118],[119],[120],[121],[122],[123],[124],[125],[126],[127],[128],[129],[130],[131],[132],[133],[134],[135],[136],[137],[138],[139],[140],[141],[142],[143],[144],
		    [145],[146],[147],[148],[149],[150]
    FROM PivotTable t1
    INNER JOIN inaSAM.dbo.iReportes t2
	   on t2.codEmpresa=@codEmpresa
		  and t2.nomIPad=@nomIPad
		  and t2.codReporte=@codReporte
    INNER JOIN inaSAM.dbo.iClientes t3
	   on t2.codEmpresa=t3.codEmpresa
		  and t2.codCliente=t3.codCliente
    INNER JOIN inaSAM.dbo.iAgentes t4
	   on t2.codEmpresa=t4.codEmpresa
		  and t2.codAgente=t4.CodAgente
    INNER JOIN inaSAM.dbo.iClientesLDir t5
	   on t2.codEmpresa=t5.codEmpresa
		  and t2.codCliente=t5.codCliente
		  and t5.linDirCli=1
END
GO
