SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO







-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 25/10/2015
-- Description:	Consumos Cliente
--				Mes actual
-- ========================================================
CREATE view [dbo].[vstgF3ConsumosClienteM] as

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
				when CodNivel1=1 then format(KilosCafe,'#,##0.##','es-ES') + 'Kgs' 
				else format(Cantidad,'#,##0.##')
			  end
		     + '</TD><TD align="right">'
			+ case -- Importe en €
				when t1.CodCadena<>0 and t1.CodTipoCliente IN('26','31') then '0'
				when Importe<>0 then format(Importe,'#,###.##€','es-ES')
			    else '0'
			  end
		     + '</TD><TD align="right">'
			--+ iif(t1.CodCadena<>0 and t1.CodTipoCliente IN('26','31'), '','  Precio medio: ')
			+ case -- Precio medio en €
				when t1.CodCadena<>0 and t1.CodTipoCliente IN('26','31') then '0'
				when CodNivel1=1 then format(PrecioMedioCafe,'#,##0.##€/Kg','es-ES')
				else format(iif(Cantidad<>0,Importe/Cantidad,0),'#,##0.##€/un','es-ES')
			  end
    FROM stgVentaArticulosClienteM t2
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
    FROM stgVentaArticulosClienteM
) t
UNION ALL
-- Total cliente
select	t2.CodCliente
		, 0 CodNivel1
		, 'TOTAL CLIENTE' Nivel1
		, IIF(t1.CodCadena<>0 and t1.CodTipoCliente IN('26','31'),''
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
		      + format(KilosCafe,'#,##0.##Kg','es-ES') 
			 + '</TD><TD align="right">'
			 + format(ImporteCafe,'#,##0.##€','es-ES')
			 + '</TD><TD align="right">'
			 + format(PrecioMedioCafe,'#,##0.##€/Kg','es-ES')
			 + '</TD><TR><TD>'
			 + 'Complementos' 
			 + '</TD><TD>'
			 + '</TD><TD align="right">'
			 + format(ImporteComplementos,'#,##0.##€','es-ES')
			 + '</TD><TD align="right">'
			 + format(RatioComplementos,'#,##0.##€/Kg','es-ES')
			 + '</TD><TR><TD>'
			 + 'PLV' 
			 + '</TD><TD>'
			 + '</TD><TD align="right">'
			 + format(ImportePLV,'#,##0.##€','es-ES')
			 + '</TD><TR><TD>'
			 + 'Otros' 
			 + '</TD><TD>'
			 + '</TD><TD align="right">'
			 + format(Importe-(ImporteCafe+ImporteComplementos+ImportePLV),'#,##0.##€','es-ES')
			 + '</TD>'
			 + '</table>'
			 + '</span></p>'
			 + '<p><span style="font-family: Calibri, sans-serif; font-size: 18px;">'
			 + 'Facturación Total:<B> ' + format(Importe,'#,##0.##€','es-ES') + '</B>'
		) + '</span></p></html>' as Consumo
from stgVentaClienteM t2
	   INNER JOIN stgF3Clientes t1
		  on t2.CodEmpresa=t1.CodEmpresa
			 and t2.CodCliente=t1.CodCliente
			 and t1.CodCanal=1
)
select *
from Tabla
where Consumo is not null
GO
