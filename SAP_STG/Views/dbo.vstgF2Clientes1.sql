SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO






-- Vista de seleccion de Maestro de Clientes SAP.
-- Funciones de Interlocutor
-- Fase 2
-- Ramon Villanueva
-- Fecha: 04/12/14

CREATE VIEW [dbo].[vstgF2Clientes1] AS

SELECT 
		convert(int, t1.KUNNR) as CodCliente
		,coalesce(t1a.VKORG,0) as CodOrgVentas
		,coalesce(upper(t21.VTEXT),'NO ASIGNADO') as OrgVentas
		,coalesce(t1a.VTWEG,0) as CodCanal
		,coalesce(upper(t20.VTEXT), 'NO ASIGNADO') as Canal
		,coalesce(t1a.SPART,0) as CodSector
		,coalesce(upper(t22.VTEXT), 'NO ASIGNADO') as Sector
		,coalesce(convert(int,t2.KUNN2) , 0) as CodRespPago
		,coalesce(upper(t2a.NAME1), upper(t1.NAME1)) as RazonSocial
		,coalesce((case t2a.STCD1 when '' then 'NO DISPONIBLE' else t2a.STCD1 end), 'N/A') as DNI_CIF
		,coalesce(convert(int,t3.PERNR) , 0) as CodVendedor
		,coalesce(upper(t3a.NombreCompleto), 'NO ASIGNADO') as Vendedor
		,coalesce(convert(int,t4.KUNN2) , 0) as CodFondoComercio
		,coalesce(upper(t4a.NAME1), 'NO ASIGNADO') as FondoComercio
		,coalesce(convert(int,t5.PERNR) , 0) as CodRespAlta
		,coalesce(upper(t5a.NombreCompleto), 'NO ASIGNADO') as RespAlta
		,coalesce(convert(int,t6.PERNR) , 0) as CodRespAltaAd
		,coalesce(upper(t6a.NombreCompleto), 'NO ASIGNADO') as RespAltaAd
		,coalesce(convert(int,t7.PERNR) , 0) as CodRespCuenta
		,coalesce(upper(t7a.NombreCompleto), 'NO ASIGNADO') as RespCuenta
		,coalesce(convert(int,t8.KUNN2) , 0) as CodCadena
		,coalesce(upper(t8a.NAME1), 'NO ASIGNADO')   as Cadena
		,coalesce(convert(int,t9.LIFNR) , 0) as CodComisionista
		,coalesce(upper(t9a.NAME1), 'NO ASIGNADO') as Comisionista
		,coalesce(convert(int,t10.LIFNR) , 0) as CodComisionistaAd
		,coalesce(upper(t10a.NAME1), 'NO ASIGNADO') as ComisionistaAd
   		,coalesce(convert(int,t11.KUNN2) , 0) as CodDistribuidor
		,coalesce(upper(t11a.NAME1), 'NO ASIGNADO')   as Distribuidor
		,0 as CodRepartidor
   		,'NO ASIGNADO' as Repartidor
		,coalesce(case t1a.KDGRP when '' then 'XX' else t1a.KDGRP end, 'XX') as CodTipoCliente
		,coalesce(UPPER(t23.KTEXT), 'NO ASIGNADO') as TipoCliente
		,coalesce(case t24.BZIRK when '' then 'XX' else t24.BZIRK end, 'XX') as CodZonaVentas -- No cojo en de t1a porque puede no existir
		,coalesce(UPPER(t24.BZTXT), 'NO ASIGNADO') as ZonaVentas
		,coalesce(case t26.PLTYP when '' then 'XX' else t26.PLTYP end, 'XX') as CodTarifa -- No cojo en de t1a porque puede no existir
		,coalesce(upper(t26.PTEXT), 'NO ASIGNADO') as Tarifa
		,coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) as CodDelegacion
		,coalesce(case t1a.VWERK when '  ' 
			 then coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0) -- Delegacion  
			 else t1a.VWERK end
			 , coalesce(case t1a.VKBUR when '  ' then 0  else t1a.VKBUR end, 0)
			 ) as CodCentroSuministro
		,coalesce(case when t1a.ZZFACCLI not in('D', 'M', 'N') then 'X' else t1a.ZZFACCLI end, 'N/A') as TipoFacturacion
		,coalesce(t1a.ZZCONSUMO, 0) as ConsumoAnualPrevisto
		,case coalesce(t1a.ZZGAMA, 'XX') when '' then 'XX' else coalesce(t1a.ZZGAMA, 'XX') end as CodGamaConsumo
		,coalesce(t1a.ZZPRGAMA, 0) as PrecioGamaConsumo
		,coalesce(t1a.ZZFECHALT,0) FechaAltaComercial
		,coalesce(t1a.ZZFECHBAJ,0) FechaBajaComercial
		,case t1a.ZZCONTDEU when 'X' then 'S' else 'N' end as NoControlDeuda
		,case t1a.ZZCLIESTAC when 'X' then 'S' else 'N' end as ClienteEstacional
		,case coalesce(t1a.ZTERM, 'XX') when '' then 'XX' else coalesce(t1a.ZTERM, 'XX') end as CodFormaPago
		,coalesce(upper(t25.TEXT1), 'NO ASIGNADO') as FormaPago
		-- Datos clientes Potenciales
		,coalesce(t1a.ZZPROVACT, 'N/A') as CodProveedorActual
		,coalesce(upper(t30.DDTEXT), 'NO ASIGNADO') as ProveedorActual
		,case coalesce(t1a.ZZCONTVIG, ' ') when 'X' THEN 'S' ELSE 'N' end as ContratoVigente
		,coalesce(t1a.ZZFECHVEN, '00000000') as FechaFinContrato
		,case coalesce(t1a.ZZMAQUINA, ' ') when 'X' THEN 'S' ELSE 'N' end as Maquina
		,coalesce(t1a.ZZMODELO, 'N/A') as CodModeloMaquina
		,coalesce(upper(t31.DDTEXT), 'NO ASIGNADO') as ModeloMaquina
		,coalesce(t1a.ZZTIPOCON, 'N/A') as CodTipoContrato
		,coalesce(upper(t32.DDTEXT), 'NO ASIGNADO') as TipoContrato
		,coalesce(t1a.ZZOTRINV, 'NO ASIGNADO') as OtroTipoInversion
		,coalesce(t1a.ZZRITMOE, 'NO ASIGNADO') as RitmoEntregaActual
		,coalesce(t1a.ZZHORAE, 'NO ASIGNADO') as HorarioEntrega
		,coalesce(t1a.ZZFACTT, 'NO ASIGNADO') as FacturacionTotal
		,coalesce(t1a.ZZKGSEM, 'NO ASIGNADO') as KgSemana
		,coalesce(t1a.ZZPRECI, 'NO ASIGNADO') as Precio
		,coalesce(t1a.ZZGAMAP, 'N/A') as CodGamaProductoActual
		,coalesce(t29.Nivel4, 'NO ASIGNADO') as GamaProductoActual
		,coalesce(t1a.ZZPLV, 'NO ASIGNADO') as MarketingPLV
		,case coalesce(t1a.ZZCLIENTE, 'N/A') when '' then 'N/A' else coalesce(t1a.ZZCLIENTE, 'N/A') end as NumeroCliente
		,coalesce(t1a.ZZKSEM, 0.00) as KGAño
		,coalesce(t1a.ZZACTPRIN, 'N/A') as CodActividadPrincipal
		,coalesce(upper(t27.DDTEXT), 'NO ASIGNADO') as ActividadPrincipal
		,coalesce(t1a.ZZNSEDES, 'N/A') as NumeroEstablecimientos
		,coalesce(t1a.ZZMARCPROP, 'X') as MarcaPropia
		,coalesce(t1a.ZZMARCAP, 'NO ASIGNADO') as NombreMarcaPropia
		,coalesce(t1a.ZZPROPCLTE, 'N/A') as CodPropiedadCliente
		,coalesce(upper(t28.DDTEXT), 'NO ASIGNADO') as PropiedadCliente
		,coalesce(t1a.ZZNEMPL, 'N/A') as Personal
FROM	KNA1 as t1 -- Datos del Maestro de clientes
		LEFT OUTER JOIN KNVV as t1a -- Datos de Ventas
			ON	t1.MANDT=t1a.MANDT 
				and t1.KUNNR=t1a.KUNNR  
		LEFT OUTER JOIN TVTWT as t20 -- Canal de ventas
			ON	t1a.MANDT=t20.MANDT 
				and t1a.VTWEG=t20.VTWEG 
		LEFT OUTER JOIN TVKOT as t21 -- Organizacion de ventas
			ON	t1a.MANDT=t21.MANDT 
				and t1a.VKORG=t21.VKORG 
		LEFT OUTER JOIN TSPAT as t22 -- Sector
			ON	t1a.MANDT=t22.MANDT 
				and t1a.SPART=t22.SPART 
		LEFT OUTER JOIN T151T as t23 -- Tipo de cliente
			ON	t1a.MANDT=t23.MANDT 
				and t1a.KDGRP=t23.KDGRP 
		LEFT OUTER JOIN T171T as t24 -- Zona de Ventas
			ON	t1a.MANDT=t24.MANDT 
				and t1a.BZIRK=t24.BZIRK 
		LEFT OUTER JOIN T052U as t25 -- Forma de Pago
			ON	t1a.MANDT=t25.MANDT 
				and t1a.ZTERM=t25.ZTERM 
				and t25.ZTAGG=0 
		LEFT OUTER JOIN T189T as t26 -- Tarifa
			ON	t1a.MANDT=t26.MANDT 
				and t1a.PLTYP=t26.PLTYP 
		LEFT OUTER JOIN DD07T as t27 -- Actividad Principal
			ON	t27.DOMNAME='ZACTPRIN'
				and t27.AS4LOCAL='A'
				and t1a.ZZACTPRIN=t27.DOMVALUE_L 
		LEFT OUTER JOIN DD07T as t28 -- Propiedad Cliente
			ON	t28.DOMNAME='ZPROPCLTE'
				and t28.AS4LOCAL='A'
				and t1a.ZZACTPRIN=t28.DOMVALUE_L 
		LEFT OUTER JOIN vstgF2JerarquiaProductos as t29 -- Gama Producto actual
			ON	t1a.ZZGAMAP=t29.JerarquiaSAP 
		LEFT OUTER JOIN DD07T as t30 -- Proveedor Actual
			ON	t30.DOMNAME='ZPROVCAFE'
				and t30.AS4LOCAL='A'
				and t1a.ZZACTPRIN=t30.DOMVALUE_L 
		LEFT OUTER JOIN DD07T as t31 -- Modelo Maquina
			ON	t31.DOMNAME='ZMODELO'
				and t31.AS4LOCAL='A'
				and t1a.ZZACTPRIN=t31.DOMVALUE_L 
		LEFT OUTER JOIN DD07T as t32 -- Tipo contrato
			ON	t32.DOMNAME='ZTIPOCON'
				and t32.AS4LOCAL='A'
				and t1a.ZZACTPRIN=t32.DOMVALUE_L 
		-- Funciones de interlocutor ***********************************
		LEFT OUTER JOIN KNVP as t2
			ON	t1a.MANDT=t2.MANDT 
				and t1a.KUNNR=t2.KUNNR 
				and t1a.VKORG=t2.VKORG 
				and t1a.VTWEG=t2.VTWEG 
				and t1a.SPART=t2.SPART 
				and t2.PARVW='RG' -- Responsable de pago
				and t2.PARZA=0
		LEFT OUTER JOIN KNA1 as t2a -- Datos del responsable de pago
			ON  t2.MANDT=t2a.MANDT COLLATE DATABASE_DEFAULT
				and t2.KUNN2=t2a.KUNNR COLLATE DATABASE_DEFAULT
		LEFT OUTER JOIN KNVP as t3
			ON	t1a.MANDT=t3.MANDT 
				and t1a.KUNNR=t3.KUNNR  
				and t1a.VKORG=t3.VKORG 
				and t1a.VTWEG=t3.VTWEG 
				and t1a.SPART=t3.SPART 
				and t3.PARVW='ZV' -- Vendedor
				and t3.PARZA=0
		LEFT OUTER JOIN stgF2Vendedores as t3a -- Datos del vendedor
			ON  t3a.CodEmpresa=2
				and t3.PERNR=t3a.CodVendedor
		LEFT OUTER JOIN KNVP as t4
			ON	t1a.MANDT=t4.MANDT 
				and t1a.KUNNR=t4.KUNNR 
				and t1a.VKORG=t4.VKORG 
				and t1a.VTWEG=t4.VTWEG 
				and t1a.SPART=t4.SPART 
				and t4.PARVW='ZF' -- Fondo de Comercio
				and t4.PARZA=0
		LEFT OUTER JOIN KNA1 as t4a -- Datos del fondo de comercio
			ON  t4.MANDT=t4a.MANDT COLLATE DATABASE_DEFAULT
				and t4.KUNN2=t4a.KUNNR COLLATE DATABASE_DEFAULT
		LEFT OUTER JOIN KNVP as t5
			ON	t1a.MANDT=t5.MANDT 
				and t1a.KUNNR=t5.KUNNR 
				and t1a.VKORG=t5.VKORG 
				and t1a.VTWEG=t5.VTWEG 
				and t1a.SPART=t5.SPART 
				and t5.PARVW='ZR' -- Responsable de alta
				and t5.PARZA=0
		LEFT OUTER JOIN stgF2Vendedores as t5a -- Datos del responsable de alta
			ON  t5.MANDT=100
				and t5.PERNR=t5a.CodVendedor
		LEFT OUTER JOIN KNVP as t6
			ON	t1a.MANDT=t6.MANDT 
				and t1a.KUNNR=t6.KUNNR 
				and t1a.VKORG=t6.VKORG 
				and t1a.VTWEG=t6.VTWEG 
				and t1a.SPART=t6.SPART 
				and t6.PARVW='ZS' -- Responsable de alta adicional
				and t6.PARZA=0
		LEFT OUTER JOIN stgF2Vendedores as t6a -- Datos del responsable de alta adicional
			ON  t6.MANDT=100
				and t6.PERNR=t6a.CodVendedor
		LEFT OUTER JOIN KNVP as t7
			ON	t1a.MANDT=t7.MANDT 
				and t1a.KUNNR=t7.KUNNR 
				and t1a.VKORG=t7.VKORG 
				and t1a.VTWEG=t7.VTWEG 
				and t1a.SPART=t7.SPART 
				and t7.PARVW='ZB' -- Responsable de cuenta
				and t7.PARZA=0
		LEFT OUTER JOIN stgF2Vendedores as t7a -- Datos del responsable de cuenta
			ON  t7.MANDT=100
				and t7.PERNR=t7a.CodVendedor
		LEFT OUTER JOIN KNVP as t8
			ON	t1a.MANDT=t8.MANDT 
				and t1a.KUNNR=t8.KUNNR 
				and t1a.VKORG=t8.VKORG 
				and t1a.VTWEG=t8.VTWEG 
				and t1a.SPART=t8.SPART 
				and t8.PARVW='ZJ' -- Cadena
				and t8.PARZA=0
		LEFT OUTER JOIN KNA1 as t8a -- Datos de la cadena
			ON  t8.MANDT=t8a.MANDT COLLATE DATABASE_DEFAULT
				and t8.KUNN2=t8a.KUNNR COLLATE DATABASE_DEFAULT
		LEFT OUTER JOIN KNVP as t9
			ON	t1a.MANDT=t9.MANDT 
				and t1a.KUNNR=t9.KUNNR 
				and t1a.VKORG=t9.VKORG 
				and t1a.VTWEG=t9.VTWEG 
				and t1a.SPART=t9.SPART 
				and t9.PARVW='ZC' -- Comisionista
				and t9.PARZA=0
		LEFT OUTER JOIN LFA1 as t9a -- Datos del comisionista
			ON  t9.MANDT=t9a.MANDT COLLATE DATABASE_DEFAULT
				and t9.LIFNR=t9a.LIFNR COLLATE DATABASE_DEFAULT
		LEFT OUTER JOIN KNVP as t10
			ON	t1a.MANDT=t10.MANDT 
				and t1a.KUNNR=t10.KUNNR 
				and t1a.VKORG=t10.VKORG 
				and t1a.VTWEG=t10.VTWEG 
				and t1a.SPART=t10.SPART 
				and t10.PARVW='ZH' -- Comisionista adicional
				and t10.PARZA=0
		LEFT OUTER JOIN LFA1 as t10a -- Datos del comisionista adicional
			ON  t10.MANDT=t10a.MANDT COLLATE DATABASE_DEFAULT
				and t10.LIFNR=t10a.LIFNR COLLATE DATABASE_DEFAULT
		LEFT OUTER JOIN KNVP as t11
			ON	t1a.MANDT=t11.MANDT 
				and t1a.KUNNR=t11.KUNNR 
				and t1a.VKORG=t11.VKORG 
				and t1a.VTWEG=t11.VTWEG 
				and t1a.SPART=t11.SPART 
				and t11.PARVW='ZG' -- Distribuidor
				and t11.PARZA=0
		LEFT OUTER JOIN KNA1 as t11a -- Datos del distribuidor
			ON  t11.MANDT=t11a.MANDT COLLATE DATABASE_DEFAULT
				and t11.KUNN2=t11a.KUNNR COLLATE DATABASE_DEFAULT



























GO
