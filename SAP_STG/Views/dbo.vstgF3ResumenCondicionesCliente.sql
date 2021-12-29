SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO








-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 28/03/2015
-- Description:	Condiciones por cliente
-- ========================================================
CREATE view [dbo].[vstgF3ResumenCondicionesCliente] as
-- Puedo crear una vista en vez de una funcion
-- En el grid estan todas aunque en el text no se vean

SELECT CodCliente, CodNivel1, Nivel1
     --+ '<tr><td colspan="4"><hr/></td></tr>'  Linea horizontal
,'<html><style>' +
'.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
'.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
'.tab tr:nth-child(even) {background-color: #dddddd}' +
'.tab {width:100%}' +
'</style>' +
'<table class="tab" cellpadding=1 cellspacing=0 border=1>' 
+ '<TR><TH><B>Producto</B></TH><TH><B>Precio Clte</B></TH><TH><B>Promoción</B></TH><TH><B>Importe Dto</B></TH></TR>'

+ stuff( (
	   SELECT ' '  
			+ '<TR><TD>'
			+ rtrim(CodArticulo) + '.-' + rtrim(Articulo) 
			+ '</TD><TD align="right">'
			--+ '  Precio Clte: ' 
			+ case when CondEsp='N' then '*' else '' end -- A tarifa *
			+ format(PrecioCliente,'#,##0.## €/','es-ES') + rtrim(Unidad_Medida)
		     + '</TD><TD align="right">'
			+ case -- Promocion
				when Base<>0 then format(Base,'#,###.##','es-ES') + '+' + format(Regalo,'#,###.##','es-ES')
			    else ''
			  end
		     + '</TD><TD align="right">'
			+ case -- Importe en €
				when Importe<>0 then format(Importe,'#,###.## €','es-ES')
			    else ''
			  end
    FROM stgF3CondicionesCliente t2
    WHERE	t.CodCliente = t2.CodCliente
			and t.CodNivel1=t2.CodNivel1
			--and CantMes2>0 -- No me fijo en las ventas para las condiciones
			--and NumReg<6
	ORDER BY CantMes2 desc
    FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)') , 1, 1, '') 
   		     + '</TD><br></table></html>'
    Condicion
FROM (
    SELECT DISTINCT CodCliente,CodNivel1, Nivel1
    FROM stgF3CondicionesCliente
) t

GO
