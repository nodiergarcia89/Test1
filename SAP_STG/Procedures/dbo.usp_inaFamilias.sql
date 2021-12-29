SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 11/01/2015
-- Description:	Completar Familias
-- =============================================
CREATE procedure [dbo].[usp_inaFamilias]
as
begin
	
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	insert into inaFamilias
	select t1.CodEmpresa
		  ,t1.codFamilia
		  ,t1.codSubFamilia
		  ,t1.desFamilia
		  ,row_number() over(partition by t1.CodFamilia order by t1.CodSubFamilia) as ordFamilia
		  ,t1.JerarquiaSAP
		  ,t1.NuevaDescripcion
		  ,'' nomIcoFamilia
		  ,coalesce(t2.NumArticulos, 0) NumArticulos
		  ,case
			when t1.codSubfamilia=0 then 1
			when coalesce(t2.NumArticulos, 0) >0 then 1
			else 0
		   end Ina
	from vIna_iFamiliasF1 t1
	left outer join 
		(select JerarquiaSAP, count(*) NumArticulos
			from stgF2ArticulosSAP
			group by JerarquiaSAP) t2
		on convert(int,t1.JerarquiaSAP)=convert(int,t2.JerarquiaSAP)
	left outer join inaFamilias t3
		on t1.CodEmpresa=t3.CodEmpresa
			and t1.CodFamilia=t3.CodFamilia
			and t1.CodSubFamilia=t3.CodSubFamilia
	where 
	 t3.CodEmpresa is null

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
end
GO
