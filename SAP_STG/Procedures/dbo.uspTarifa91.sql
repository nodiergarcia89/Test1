SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 06/08/2015
-- Description:	Ajuste de la tarifa 90 con la 91
--  Los articulos de la tarifa 90 se sobreescriben 
-- con los de la tarifa 91, y los que no existen
-- se añaden.
-- =============================================
CREATE PROCEDURE [dbo].[uspTarifa91]  AS

BEGIN

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	MERGE sym_iTarifasLin AS T
	USING vIna_iTarifasLin91 AS S
	ON (T.codEmpresa = S.CodEmpresa
		and T.codTarifa=S.codTarifa
		and T.codMagnitud=S.codMagnitud
		and T.codArticulo=S.codArticulo
		and T.canMinima=S.cantMinima	) 
	WHEN NOT MATCHED BY TARGET 
		THEN INSERT([codEmpresa]
					 ,[codTarifa]
					,[codMagnitud]
					,[codArticulo]
					,[canMinima]
					,[preArticulo]
					,[flaPreMagnitud]
					,[tpcDto01Def]
					,[tpcDto02Def]
					,[tpcDto01Max]
					,[tpcDto02Max]
					,[PuntosSinDto]
					,[PuntosConDto]
					,[flaPuntosUnitarios]) 
					VALUES(S.codEmpresa
							,S.codTarifa
							,S.codMagnitud
							,S.codArticulo
							,S.cantMinima
							,S.preArticulo
							,S.flaPreMagnitud
							,S.tcpDto01Def
							,S.tcpDto02Def
							,S.tcpDto01Max
							,S.tcpDto02Max
							,S.PuntosSinDto
							,S.PuntosConDto
							,S.flaPuntosUnitarios)
	WHEN MATCHED 
		THEN UPDATE SET T.preArticulo=S.preArticulo
						,T.flaPreMagnitud=S.flaPreMagnitud
						,T.tpcDto01Def=S.tcpDto01Def
						,T.tpcDto02Def=S.tcpDto02Def
						,T.tpcDto01Max=S.tcpDto01Max
						,T.tpcDto02Max=S.tcpDto02Max
						,T.PuntosSinDto=S.PuntosSinDto
						,T.PuntosConDto=S.PuntosConDto
						,T.flaPuntosUnitarios=S.flaPuntosUnitarios;

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
