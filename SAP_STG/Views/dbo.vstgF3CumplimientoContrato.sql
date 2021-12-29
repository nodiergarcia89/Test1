SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO






-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 17/03/2015
-- Description:	Analisis Cumplimiento Contrato por cliente
-- Modificacion: 26/11/2015
--  Quitar el control de fecha
-- Modificacion: 27/11/2015
--  Asegurar un unico contrato por cliente
-- ========================================================
CREATE view [dbo].[vstgF3CumplimientoContrato] as
select	--t1.CodEmpresa
		--, t1.KUNNR CodPagador
		 t2.KUNNR CodEstablecimiento
		--, t1.ESTABL CodCliente
		, t1.VBELN NumContrato
		, choose(t1.STATUS
					,'Pendiente'
					,'Análisis OK'
					,'Pendiente Confirmacion Propuesta'
					,'Confirmación Delegación' 
					,'Aprobado'
					,'Confirmación Instalación'
					,'Firma Verificada'
					,'Jurídico'
					,'Rechazado'
					,'N/A'
					) StatusContrato
		, convert(date,t1.FECHA_INI) FechaInicio
		, convert(date,t1.FECHA_FIN) FechaFin
		, convert(int,t1.MESESP+1) MesesDuracion
		, convert(int,round((t1.MESESP+1) / 12.00,0,0)) AñosDuracion
		, t1.KILOS KilosMes
		, t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12 KilosAño
		, t1.KGTOT KilosPeriodo
		, ((t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12) - t1.KGTOT) KgsPteAmort
		, convert(money, case t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0))
			when 0 then 0
				else
					t1.KGTOT * t1.INVERSION / ( t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12) 
			end) EurosAmort
		--, convert(money, case t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0))
		--	when 0 then 0
		--		else
		--			((t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12) - t1.KGTOT) * t1.INVERSION / ( t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12) 
					
		--	end) EurosPteAmort
		, iif((t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0))) <>0 ,
			(t2.IMPORTE_RAPPEL_A / (t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0))*12)) 
				*  ((t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12) - t1.KGTOT)
			, 0) EurosPteAmort -- (Rappel anticipado/Kg fijados) X Kgs.pendiente amortizar
		, (t1.PORC_CUMP) PorcCump
--		, (t1.FACT_EST) FactObjMes
		, (t2.IMPORTE / t2.MESES) FactObjMes
		, t1.PRVENTA PrecioPropuestoSAP
		, t1.INVERSION Inversion
		, case when t1.ESTABL='*' then 
				rtrim(convert(char,(select count(*) Contratos 
					from dbo.ZCAH003
						where CodEmpresa=t1.CodEmpresa
							  and MANDT=100
							  and VBELN =t1.VBELN COLLATE DATABASE_DEFAULT))) + ' establecimientos'
			else 'Unico establecimiento' end Establecimientos
		/* Indemnización:

		Importe Rappel anticipado + Inversión maquinaria (restando el % de amortización siguiendo lo indicado abajo) + (Kgs pendiente amortizar X 2€/kg)
		(Rappel anticipado + Valor de la maquinaria (para el cálculo de lo de abajo tienes fecha inicio y fin del contrato, además del valor de la maquinaria) + (Kgs. Pendiente amortizar X 2€/kg)

		En cuanto a la amortización hay que restarlo al valor de la inversión en maquinaria teniendo en cuenta lo siguiente:

		o	Si el contrato es de duración inferior a 5 años: 10% por año transcurrido sobre el campo Valor Maquinaria. 
		o	Si el contrato tiene una duración de 5 años o superior: 
				10% por año transcurrido sobre el campo Valor Maquinaria, si no han transcurrido 4 años. Superior a un año desde la fecha inicio contrato e inferior a 4. 
				45% sobre el campo Valor Maquinaria, entre el 4º y el 5º año de vigencia del contrato. Superior a 4 años desde la fecha inicio contrato e inferior a 5.
				60% sobre el campo Valor Maquinaria, durante el 5º año de vigencia del contrato. Superior a 5 años desde la fecha inicio contrato e inferior a 6. 
				75% sobre el campo Valor Maquinaria, si el plazo de vigencia es superior al 5º año de vigencia del contrato. Superior a 6 años desde la fecha inicio contrato.
		*/
		, t2.IMPORTE_RAPPEL_A 
			+ ((t1.KILOS * convert(int,round((t1.MESESP+1) / 12.00,0,0)) * 12) - t1.KGTOT) * 2
			+ case 
				when convert(int,round((t1.MESESP+1) / 12.00,0,0)) < 5 then  --Inferior a 5 Años de Duracion
						(1-datediff(year,convert(date,t1.FECHA_INI),getdate()) * .10 )
						* coalesce((select sum(Importe)
									from vstgF2MaterialCedidoContrato
										where Borrado='N'
										and NumContrato=t1.VBELN COLLATE DATABASE_DEFAULT and CodCliente=t2.KUNNR COLLATE DATABASE_DEFAULT 
												),0)
				else -- Contratos con mas de 5 años de duracion
					case 
						when datediff(year,convert(date,t1.FECHA_INI),getdate()) < 4 then  -- No han transcurrido 4 años
							(1-datediff(year,convert(date,t1.FECHA_INI),getdate()) * .10 )
							* coalesce((select sum(Importe)
										from vstgF2MaterialCedidoContrato
											where Borrado='N'
											and NumContrato=t1.VBELN COLLATE DATABASE_DEFAULT and CodCliente=t2.KUNNR COLLATE DATABASE_DEFAULT)
												,0)
						when datediff(year,convert(date,t1.FECHA_INI),getdate()) between 4 and 5 then  -- Entre el 4º y el 5º año de vigencia
							.55 
							* coalesce((select sum(Importe)
										from vstgF2MaterialCedidoContrato
											where Borrado='N'
											and NumContrato=t1.VBELN COLLATE DATABASE_DEFAULT
											and CodCliente=t2.KUNNR COLLATE DATABASE_DEFAULT),0)
						when datediff(year,convert(date,t1.FECHA_INI),getdate()) < 6 then  -- Durante el 5º año de vigencia
							.40 
							* coalesce((select sum(Importe)
										from vstgF2MaterialCedidoContrato
											where Borrado='N'
											and NumContrato=t1.VBELN COLLATE DATABASE_DEFAULT
											and CodCliente=t2.KUNNR COLLATE DATABASE_DEFAULT),0)
						else																	-- Superior al 5º año
							.25 
								* coalesce((select sum(Importe)
											from vstgF2MaterialCedidoContrato
												where Borrado='N' 
												and NumContrato=t1.VBELN COLLATE DATABASE_DEFAULT
												and CodCliente=t2.KUNNR COLLATE DATABASE_DEFAULT),0)
					end
				end
		  as Indemnizacion 
		--***************************************************************************************************************************************
		, t2.INDEMNIZ1 IndemKgRap
		, t2.INDEMNIZ2 IndemKgMat
		, t2.RAPPEL_SIN_AVAL SinAval
		, t2.IMPORTE_RAPPEL_A AvalImporte
		, t2.FECHA_RAPPEL FechaVtoAval
		, t2.DUR_AVAL_RAPPEL DuracionAñosAval
		--, t1.MAQ1TX + CHAR(13)+CHAR(10) + t1.MAQ2TX + CHAR(13)+CHAR(10) + t1.MAQ3TX + CHAR(13)+CHAR(10)
		--  + case t1.MAQ4 when '*' then 'MAS MATERIAL CEDIDO'
		--		else t1.MAQ4TX end MaterialCedido
		, dbo.udfMaterialCedido(t2.KUNNR, t1.VBELN) MaterialCedido
		,coalesce((select sum(Importe)
						from vstgF2MaterialCedidoContrato
							where Borrado='N'
							and NumContrato=t1.VBELN COLLATE DATABASE_DEFAULT
							and CodCliente=t2.KUNNR COLLATE DATABASE_DEFAULT),0)  ValorMaquinaria 
		,t2.IMPORTE_RAPPEL_A RappelAnticipado
from	ZSC007 t1
		inner join vstgF2UltimoContratoClte t2
			on t1.MANDT COLLATE DATABASE_DEFAULT=t2.MANDT
				and t1.VBELN COLLATE DATABASE_DEFAULT=t2.VBELN
--where convert(date,t1.FECHA_FIN)>getdate()
--and t1.STATUS in('5','6','7')
where t1.STATUS in('5','6','7')

GO
