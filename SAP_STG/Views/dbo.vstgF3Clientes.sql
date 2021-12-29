SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO







-- Maestro de Clientes SAP.
-- Fase 3
-- Ramon Villanueva
-- Fecha: 11/12/14

CREATE VIEW [dbo].[vstgF3Clientes] AS
SELECT    t1.CodCliente
		, t1.NombreCliente
		, t1.Direccion
		, t1.Poblacion
		, t1.CP
		, t1.CodPais
		, t1.Pais
		, t1.CodProvincia
		, t1.Provincia
		, t1.Telefono
		, t1.Fax
		, LEFT(t1.DireccionEmail,50) DireccionEmail
		, t1.FechaCreacionRegistro
		, t1.CodGrupoClientes
		, t1.GrupoClientes
		, t1.Baja
		, t2.CodOrgVentas
		, t2.OrgVentas
		, t2.CodCanal
		, t2.Canal
		, t2.CodSector
		, t2.Sector
		, t2.CodRespPago
		, t2.RazonSocial
		, t2.DNI_CIF
		, t2.CodFormaPago
		, t2.FormaPago
		, t2.CodVendedor
		, t2.Vendedor
		, t2.CodFondoComercio
		, t2.FondoComercio
		, t2.CodRespAlta
		, t2.RespAlta
		, t2.CodRespAltaAd
		, t2.RespAltaAd
		, t2.CodRespCuenta
		, t2.RespCuenta
		, t2.CodCadena
		, t2.Cadena
		, t2.CodComisionista
		, t2.Comisionista
		, t2.CodComisionistaAd
		, t2.ComisionistaAd
		, t2.CodDistribuidor
		, t2.Distribuidor
		, t2.CodRepartidor
		, t2.Repartidor
		, case when t2.CodTipoCliente in('20', '21', '23', '26', '27', '28', '29') THEN 1
			   when t2.CodTipoCliente in('24', '25', '30','31') THEN 2
			   else 0
		  end as CodTipoHoreca
		, case when t2.CodTipoCliente in('20', '21', '23', '26', '27', '28', '29') THEN 'HORECA INDIRECTA'
			   when t2.CodTipoCliente in('24', '25', '30','31') THEN 'HORECA DIRECTA'
			   else 'OTROS'
		  end as TipoHoreca
		, t2.CodTipoCliente
		, t2.TipoCliente
		, t2.CodZonaVentas
		, t2.ZonaVentas
		, t2.CodTarifa
		, t2.Tarifa
		, t2.CodDelegacion
		, coalesce(t3.Delegacion, 'NO ASIGNADO') Delegacion
		, t1.CodDelegacionOrigen
		, t1.DelegacionOrigen
		, t2.CodCentroSuministro
		, case t2.TipoFacturacion
			when 'D' then 'DIARIA'
			when 'M' then 'MENSUAL'
			when 'N' then 'TICKET'
			else 'NO ASIGNADO'
		  end as TipoFacturacion
		, t2.ConsumoAnualPrevisto
		, t2.CodGamaConsumo
		, coalesce(t4.Nivel2, 'NO ASIGNADO') GamaConsumo
		, t2.PrecioGamaConsumo
		, t2.FechaAltaComercial FechaAltaComercial_key
		, t2.FechaBajaComercial FechaBajaComercial_key
		, t2.NoControlDeuda
		, t2.ClienteEstacional
		-- Datos clientes Potenciales
		,t2.CodProveedorActual
		,t2.ProveedorActual
		,t2.ContratoVigente
		,t2.FechaFinContrato
		,t2.Maquina
		,t2.CodModeloMaquina
		,t2.ModeloMaquina
		,t2.CodTipoContrato
		,t2.TipoContrato
		,t2.OtroTipoInversion
		,t2.RitmoEntregaActual
		,t2.HorarioEntrega
		,t2.FacturacionTotal
		,t2.KgSemana
		,t2.Precio
		,t2.CodGamaProductoActual
		,t2.GamaProductoActual
		,t2.MarketingPLV
		,t2.NumeroCliente
		,t2.KGAño
		,t2.CodActividadPrincipal
		,t2.ActividadPrincipal
		,t2.NumeroEstablecimientos
		,t2.MarcaPropia
		,t2.NombreMarcaPropia
		,t2.CodPropiedadCliente
		,t2.PropiedadCliente
		,t2.Personal
		,case coalesce(t5.CodCliente,0)
			when t1.CodCliente then 1
			else 0
		end ContratoAct
FROM    stgF2Clientes AS t1 INNER JOIN
        stgF2Clientes1 AS t2 
			ON t1.CodCliente = t2.CodCliente
		LEFT OUTER JOIN vstgF2Delegaciones as t3
			ON t2.CodDelegacion=t3.CodDelegacion
		LEFT OUTER JOIN vstgF2JerarquiaProductos as t4
			ON t2.CodGamaConsumo=t4.JerarquiaSAP
		LEFT OUTER JOIN vstgF3ClientesContratoAct as t5
			ON t1.CodCliente=t5.CodCliente

GO
