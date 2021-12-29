SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date: 18/02/16
-- Description:	Vista de Junk para visitas PDA de XONE
-- ==================================================================
CREATE VIEW [dbo].[vstgjunkVisitasXONE] as
select distinct  
		CodTipoVisita
		,case CodTipoVisita
			when 'I' then 'Improductivo'
			when 'V' then 'Vending'
			when 'A' then 'Albarán'
			when 'C' then 'Cobro'
			when 'F' then 'Factura'
			when 'N' then 'Cobro Cancelado'
			when 'W' then 'Vending Cancelada'
			when 'Y' then 'Albarán Cancelado'
			when 'Z' then 'Factura Cancelada'
			when 'P' then 'Preventa'
			else 'No aplica'
		end TipoVisita
		,case CodTipoVisita
			when 'I' then 'Normal'
			when 'V' then 'Normal'
			when 'A' then 'Normal'
			when 'C' then 'Normal'
			when 'F' then 'Normal'
			when 'N' then 'Cancelada'
			when 'W' then 'Cancelada'
			when 'Y' then 'Cancelada'
			when 'Z' then 'Cancelada'
			when 'P' then 'Normal'
			else 'No aplica'
		end Visita
		,FacEnCentral
		,case FacEnCentral
			when 'S' then 'Factura Mensual'
			when 'N' then 'Factura PDA'
			else 'No aplica'
		 end FacEnCentral_des
		,FacturaSN
		,case FacturaSN
			when 'S' then 'Factura'
			when 'N' then 'Ticket'
			else 'No aplica'
		 end FacturaSN_des
		,CodTipoCobro 
		,case CodTipoCobro
			when 'E' then 'Efectivo'
			when 'T' then 'Talon'
			else 'No aplica'
		 end CodTipoCobro_des
		,CodTipoDoc
		,case CodTipoDoc
			when 'F' then 'Factura'
			when 'A' then 'Albaran'
		    else 'No aplica'
		 end CodTipoDoc_des
		,CodTipoLinea
		,case CodTipoLinea
			when '0' then 'Normal'
			when '1' then 'Devolución'
			when '2' then 'Regalo normal'
			when '3' then 'Regalo de promoción en dto. comercial'
			when '4' then 'Regalo de promoción en oferta'
			when '5' then 'Obsequio de oferta'
			when '6' then 'Oferta con cantidad limite'
			when '7' then 'Variación de precio por aplicación de descuento comercial'
			when '8' then 'Variación de precio por aplicación de oferta'
			when '9' then 'Se ha aplicado sólo el descuento escalado'
			when 'A' then 'Se ha aplicado el descuento escalado más la oferta'
			when 'B' then 'Se ha aplicado el descuento escalado más el descuento comercial'
			when 'C' then 'Componente kit'
			else 'No aplica'
		 end CodTipoLinea_des
		,Lotes
		,case Lotes
			when 'S' then 'Con lotes'
			when 'N' then 'Sin lotes'
			else 'No aplica'
		 end Lotes_des
		,EstCobro
		,case EstCobro
			when 'S' then 'Cobrado'
			when 'N' then 'No Cobrado'
			when 'P' then 'Cobrado Parcial'
			else 'No aplica'
		 end EstCobo_des
		,NumImpresiones
		,Observaciones
		,VisitaManual
		,case VisitaManual
			when 'S' then 'Visita Manual'
			when 'N' then 'Visita PDA'
	        else 'No aplica'
		 end VisitaManual_des
		,NumVisitaManual
		,NumLiquidacion
		,CodVendedor
from stgF2VisitasXONE 

GO
