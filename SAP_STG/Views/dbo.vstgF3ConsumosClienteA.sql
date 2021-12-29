SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO







-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 25/10/2015
-- Description:	Consumos Cliente
--				Acumulado año actual
-- ========================================================
CREATE view [dbo].[vstgF3ConsumosClienteA] as

With Tabla AS
(
SELECT CodCliente, CodNivel1, Nivel1
     --+ '<tr><td colspan="4"><hr/></td></tr>'  Linea horizontal
,'<html><style>' +
'.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
'.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
'.tab tr:nth-child(even) {background-color: #dddddd}' +
'.tab {width:100%}' +
'</style>' +
'<table class="tab" cellpadding=1 cellspacing=0 border=1>' 
+ '<TR><TH><B>Producto</B></TH><TH><B>Cantidad</B></TH><TH><B>Importe</B></TH><TH><B>Precio</B></TH></TR>'
    + stuff( (
    SELECT  ' '  
			+ '<TR><TD>'
			+ rtrim(CodArticulo) + '.-' + rtrim(Articulo) 
			+ '</TD><TD align="right">'
			+ case -- Cantidad
				when CodNivel1=1 then format(KilosCafe,'#,##0.##','es-ES') + 'Kgs.'
				else format(Cantidad,'#,##0.##')
			  end
		     + '</TD><TD align="right">'
			+ case -- Importe en €
				when t1.CodCadena<>0 and t1.CodTipoCliente IN('26','31') then '0'
				when Importe<>0 then format(Importe,'#,##0.##€','es-ES')
			    else '0'
			  end
		     + '</TD><TD align="right">'
			+ case -- Precio medio en €
				when t1.CodCadena<>0 and t1.CodTipoCliente IN('26','31') then '0'
				when CodNivel1=1 then format(PrecioMedioCafe,'#,##0.##€/Kg','es-ES')
				else format(iif(Cantidad<>0,Importe/Cantidad,0),'#,##0.##€/un','es-ES')
			  end
    FROM stgVentaArticulosClienteA t2
	   INNER JOIN stgF3Clientes t1
		  on t2.CodEmpresa=t1.CodEmpresa
			 and t2.CodCliente=t1.CodCliente
			 and t1.CodCanal=1
    WHERE	t.CodEmpresa=t2.CodEmpresa
			and t.CodCliente = t2.CodCliente
			and t.CodNivel1=t2.CodNivel1
	ORDER BY Cantidad desc
    FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)') , 1, 1, '') 
       		     + '</TD><br></table></html>' Consumo
FROM (
    SELECT DISTINCT CodEmpresa,CodCliente,CodNivel1, Nivel1
    FROM stgVentaArticulosClienteA
) t
UNION ALL
-- Total cliente
select	t1.CodCliente
		, 0 CodNivel1
		, 'TOTAL CLIENTE' Nivel1
		, IIF(t3.CodCadena<>0 and t3.CodTipoCliente IN('26','31'),''
    --+ '<tr><td colspan="4"><hr/></td></tr>'  Linea horizontal
,'<html><style>' +
'.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
'.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
'.tab tr:nth-child(even) {background-color: #dddddd}' +
'.tab {width:100%}' +
'</style>' +
'<table class="tab" cellpadding=1 cellspacing=0 border=1>' 
+ '<TR><TH><B>Concepto</B></TH><TH><B>Cantidad</B></TH><TH><B>Importe</B></TH><TH><B>Precio Medio</B></TH></TR>'
		      + '<TR><TD>'
			 + 'Café' 
			 + '</TD><TD align="right">'
			 + format(t1.KilosCafe,'#,##0.##Kg','es-ES') 
				+ ' (' + rtrim(convert(char,format(iif(t1.KilosCafe<>0, (t1.KilosCafe-coalesce(t2.KilosCafe,0))/t1.KilosCafe, 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD><TD align="right">'
			 + format(t1.ImporteCafe,'#,##0.##€','es-ES')
				+ ' (' + rtrim(convert(char,format(iif(t1.ImporteCafe<>0, (t1.ImporteCafe-coalesce(t2.ImporteCafe,0))/t1.ImporteCafe, 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD><TD align="right">'
                + format(t1.PrecioMedioCafe,'#,##0.##€/Kg','es-ES')
				+ ' (' + rtrim(convert(char,format(iif(t1.PrecioMedioCafe<>0, (t1.PrecioMedioCafe-coalesce(t2.PrecioMedioCafe,0))/t1.PrecioMedioCafe, 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD><TR><TD>'
			 + 'Complementos' 
			 + '</TD><TD>'
			 + '</TD><TD align="right">'
			 + format(t1.ImporteComplementos,'#,##0.##€','es-ES')
		         + ' (' + rtrim(convert(char,format(iif(t1.ImporteComplementos<>0, (t1.ImporteComplementos-coalesce(t2.ImporteComplementos,0))/t1.ImporteComplementos, 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD><TD align="right">'
			 + format(t1.RatioComplementos,'#,##0.##€/Kg','es-ES')
			    + ' (' + rtrim(convert(char,format(iif(t1.RatioComplementos<>0, (t1.RatioComplementos-coalesce(t2.RatioComplementos,0))/t1.RatioComplementos, 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD><TR><TD>'
			 + 'PLV' 
			 + '</TD><TD>'
			 + '</TD><TD align="right">'
			 + format(t1.ImportePLV,'#,##0.##€','es-ES')
			    + ' (' + rtrim(convert(char,format(iif(t1.ImportePLV<>0, (t1.ImportePLV-coalesce(t2.ImportePLV,0))/t1.ImportePLV, 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD><TR><TD>'
			 + 'Otros' 
			 + '</TD><TD>'
			 + '</TD><TD align="right">'
			 + format(t1.Importe-(t1.ImporteCafe+t1.ImporteComplementos+t1.ImportePLV),'#,##0.##€','es-ES')
			 + ' (' + rtrim(convert(char,format(iif((t1.Importe-(t1.ImporteCafe+t1.ImporteComplementos+t1.ImportePLV))<>0, 
				  ((t1.Importe-(t1.ImporteCafe+t1.ImporteComplementos+t1.ImportePLV))-coalesce((t2.Importe-(t2.ImporteCafe+t2.ImporteComplementos+t2.ImportePLV)),0))/(t1.Importe-(t1.ImporteCafe+t1.ImporteComplementos+t1.ImportePLV))
				    , 0),'#,##0.##%','es-ES')) )+ ')'
			 + '</TD>'
			 + '</table>'
			 + '<p><span style="font-family: verdana; font-size: 18px;">'
			 + 'Facturación Total:<B> ' + format(t1.Importe,'#,##0.##€','es-ES') + '</B>'
			 + ' (' + rtrim(convert(char,format(iif(t1.Importe<>0, (t1.Importe-coalesce(t2.Importe,0))/t1.Importe, 0),'#,##0.##%','es-ES')) )+ ')'
		  ) + '</span></p></html>' as Consumo
from stgVentaClienteA t1	
		left outer join stgVentaClienteAM t2
			on t1.CodEmpresa=t2.CodEmpresa
				and t1.CodCliente=t2.CodCliente
	   INNER JOIN stgF3Clientes t3
		  on t1.CodEmpresa=t3.CodEmpresa
			 and t1.CodCliente=t3.CodCliente
			 and t3.CodCanal=1
)
select *
from Tabla
where Consumo is not null
GO
