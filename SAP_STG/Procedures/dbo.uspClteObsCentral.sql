SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================
-- Author:		Ramon Villanueva
-- Create date: 30/09/2015
-- Description:	Observaciones de Central
-- Componer las observaciones de central en iClientes
-- Modificacion 26/04/2017
--	   Meto el filtro en las observaciones
-- Modificacion 18/12/2017
--	   Quito la fecha de actualizacion para evitar datos
-- Modificacion 08/04/2020
--      Utilizar el pop-up de Clientes de Inase.
--      Se activa con el parametro ClienteAlertaObservaciones=2
--      y llamando a su sp standard.
-- ===========================================================
CREATE PROCEDURE [dbo].[uspClteObsCentral] as

BEGIN
	
	SET NOCOUNT ON;	

	SET LANGUAGE SPANISH

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	-- Recuperar funciones de Interlocutor
	select	t1.CodEmpresa
			,t1.CodCliente
			,t1.GrupoClientes
			,t1.CodVendedor
			,t1.Vendedor
			,t1.CodFondoComercio
			,t1.FondoComercio
			,t1.CodRespAlta
			,t1.RespAlta
			,t1.CodRespAltaAd
			,t1.RespAltaAd
			,t1.CodRespcuenta
			,t1.Respcuenta
			,t1.CodCadena
			,t1.Cadena
			,t1.CodComisionista
			,t1.Comisionista
			,t1.CodComisionistaAd
			,t1.ComisionistaAd
			,t1.CodDistribuidor
			,t1.Distribuidor
			,t1.CodRepartidor
			,t1.Repartidor
			,t1.Baja
			,format(t3.FechaDatos,'dd/MM/yyyy','es-ES') FechaDatos
			,coalesce(format(t2.FechaUltVisita,'dd/MM/yyyy HH:mm:ss','es-ES'),'No visitado') FechaUltVisita
			,coalesce(t2.DiasDif,0) DiasDif
			,coalesce(t2.VisitasAño,0) VisitasAño
	into #tmp_Tabla
	from stgF3Clientes t1
		left outer join vUltimaVisitaReportada t2
			on t1.CodEmpresa=t2.codempresa
				and t1.CodCliente=t2.codCliente
		left outer join stgF3FacturacionCliente t3	-- Datos de Facturacion
			ON t1.CodEmpresa=t3.CodEmpresa
				and t1.CodCliente=t3.CodCliente
	
		-- Actualizar tabla [iClientes]
--	UPDATE sym_iClientes
--		SET obsClienteNoEdi = obsClienteNoEdi + CHAR(13)+CHAR(10) ---- 26/04/2017
--									     + coalesce(	
--										  case when CodVendedor=0 then '' else 'Vendedor: ' + Vendedor + CHAR(13)+CHAR(10) end
--										+ case when CodFondoComercio=0 then '' else 'Fondo Comercio: ' + FondoComercio + CHAR(13)+CHAR(10) end
--										+ case when CodRespAlta IN(0, 199) then '' else 'Resp. Alta: ' + RespAlta + CHAR(13)+CHAR(10) end
--										+ case when CodRespAltaAd=0 then '' else 'Resp. Alta Ad: ' + RespAltaAd + CHAR(13)+CHAR(10) end
--										+ case when CodRespcuenta=0 then '' else 'Resp. Cuenta: #' + rtrim(convert(char,CodRespcuenta)) + ' ' + Respcuenta + CHAR(13)+CHAR(10) end
--										+ case when CodCadena=0 then '' else 'Cadena: ' + Cadena + CHAR(13)+CHAR(10) end
--										+ case when CodComisionista=0 then '' else 'Comisionista: ' + Comisionista + CHAR(13)+CHAR(10) end
--										+ case when CodComisionistaAd=0 then '' else 'Comisionista Ad.: ' + ComisionistaAd + CHAR(13)+CHAR(10) end
--										+ case when CodDistribuidor=0 then '' else 'Distribuidor: ' + Distribuidor + CHAR(13)+CHAR(10) end
--										+ case when CodRepartidor=0 then '' else 'Repartidor: ' + Repartidor + CHAR(13)+CHAR(10) end
--										+ case when Baja='N' then '' else CHAR(13)+CHAR(10) + 'CLIENTE DE #BAJA#'+ CHAR(13)+CHAR(10) end 
--										+ 'Ultima factura: ' + rtrim(cOALESCE(convert(char,FechaDatos),'N/D')) + CHAR(13)+CHAR(10)
----										+ 'Actualizacion.: ' + format(getdate(),'dd/MM/yyyy HH:mm:ss','es-ES') + CHAR(13)+CHAR(10)    -- 18/12/2017
--										+ 'Ultima visita.: ' + rtrim(convert(char,FechaUltVisita)) 
--											--+ case when DiasDif>0 then ' (hace ' + rtrim(convert(char,DiasDif)) + ' dias)' 
--											--	   else '' end 
--												   + CHAR(13)+CHAR(10)
--										+ iif(VisitasAño>0,'Visitas este año.....: ' + convert(char,VisitasAño),'')
--									,'REVISAR DATOS EN CENTRAL')
--	FROM sym_iClientes 
--		 LEFT OUTER JOIN #tmp_Tabla AS t2 
--			ON	sym_iClientes.codEmpresa = t2.CodEmpresa 
--				AND sym_iClientes.codCliente = t2.CodCliente
--	where sym_iClientes.codCliente not like 'ipad%'


	-- Añadir observaciones HTML de Inase -- Modificacion 08/04/2020
	EXEC [InaSAM].[dbo].[TOTAL_Observaciones_Cliente_HTML_STD]
    
    UPDATE sym_iClientes
		SET obsClienteNoEdi = obsClienteNoEdi 
+ '<html><style>' +
'.tab td {font-family: verdana;padding:2px;font-size:10pt} ' +
'.tab th {font-family: verdana;font-size:10pt} .tab' +
'</style>' +
'<table class="tab" cellpadding=0 cellspacing=0 border=0>' 	  
+ coalesce(	
		  case when CodVendedor=0 then '' else 
			 '<TR><TD><span ><B>Vendedor: </B></TD><TD>' + Vendedor + '</span></TD></TR>' end
		  + case when CodFondoComercio=0 then '' else 
			 '<TR><TD><span ><B>Fondo Comercio:</B></TD><TD>' + FondoComercio + '</span></TD></TR>' end
		  + case when CodRespAlta IN(0, 199) then '' else 
			 '<TR><TD><span ><B>Resp. Alta: </B></TD><TD>' + RespAlta + '</span></TD></TR>' end
		  + case when CodRespAltaAd=0 then '' else 
			 '<TR><TD><span ><B>Resp. Alta Ad:</B></TD><TD>' + RespAltaAd + '</span></TD></TR>' end
		  + case when CodRespcuenta=0 then '' else 
			 '<TR><TD><span ><B>Resp. Cuenta:</B></TD><TD>#' 
				+ rtrim(convert(char,CodRespcuenta)) + ' ' + Respcuenta + '</span></TD></TR>' end
		  + case when CodCadena=0 then '' else 
			 '<TR><TD><span ><B>Cadena:</B></TD><TD>' + Cadena + '</span></TD></TR>' end
		  + case when CodComisionista=0 then '' else 
			 '<TR><TD><span ><B>Comisionista:</B></TD><TD>' + Comisionista + '</span></TD></TR>' end
		  + case when CodComisionistaAd=0 then '' else 
			 '<TR><TD><span ><B>Comisionista Ad.:</B></TD><TD>' + ComisionistaAd + '</span></TD></TR>' end
		  + case when CodDistribuidor=0 then '' else 
			 '<TR><TD><span ><B>Distribuidor:</B></TD><TD>' + Distribuidor + '</span></TD></TR>' end
		  + case when CodRepartidor=0 then '' else 
			 '<TR><TD><span ><B>Repartidor:</B></TD><TD>' + Repartidor + '</span></TD></TR>' end
		  + case when Baja='N' then '' else 
			 '<TR><TD><br>' + '<span><B>CLIENTE DE #BAJA#</B></TD><TD></span></TD></TR>' end
		  + '<TR><TD><span ><B>Ultima factura:</B></TD><TD>' 
			 + rtrim(cOALESCE(convert(char,FechaDatos),'N/D')) + '</span></TD></TR>' 
		  + '<TR><TD><span ><B>Ultima visita:</B></TD><TD>' 
			 + rtrim(convert(char,FechaUltVisita)) + '</span></TD></TR>'
		  + iif(VisitasAño>0,
			 '<TR><TD><span ><B>Visitas este año: </B></TD><TD>' 
			 + TRIM(convert(char,VisitasAño)),'') + '</span></TD></TR>'
	   ,'<TR><TD><span ><B>REVISAR DATOS EN CENTRAL</B></TD><TD></span></TD></TR>') 
	   + '</TD><br></table></html>'
	FROM sym_iClientes 
		 LEFT OUTER JOIN #tmp_Tabla AS t2 
			ON	sym_iClientes.codEmpresa = t2.CodEmpresa 
				AND sym_iClientes.codCliente = t2.CodCliente
	where sym_iClientes.codCliente not like 'ipad%'


	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
	
END
GO
