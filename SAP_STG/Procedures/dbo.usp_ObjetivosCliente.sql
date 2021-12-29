SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date:	14/04/2020
-- Description:	Datos de Objetivos desde Presupuestos
-- ========================================================================
CREATE   PROCEDURE [dbo].[usp_ObjetivosCliente] AS
BEGIN
	SET NOCOUNT ON;

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
	SET LANGUAGE spanish

	-- Borrar tabla
     DELETE FROM sym_iObjetivosLin

    -- Presupuesto de Cafe
    ;WITH KilosCafe AS
    (
    SELECT CodEmpresa
	   , Año CodPeriodo
	   , CodCliente
	   , COALESCE([1],0)  cantObjetivo_1
	   , COALESCE([2],0) cantObjetivo_2
	   , COALESCE([3],0) cantObjetivo_3
	   , COALESCE([4],0) cantObjetivo_4
	   , COALESCE([5],0) cantObjetivo_5
	   , COALESCE([6],0) cantObjetivo_6
	   , COALESCE([7],0) cantObjetivo_7
	   , COALESCE([8],0) cantObjetivo_8
	   , COALESCE([9],0) cantObjetivo_9
	   , COALESCE([10],0) cantObjetivo_10
	   , COALESCE([11],0) cantObjetivo_11
	   , COALESCE([12],0) cantObjetivo_12
    FROM (SELECT CodEmpresa, CodCliente, Año, Mes,
		  KilosCafe
		FROM [sym_rpt_vObjetivosInacatalog]
		) AS tt1
    PIVOT( SUM(KilosCafe)
	   FOR Mes IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS tt2
    )
    , ImporteCafe AS
    (
    SELECT CodEmpresa
	   , Año CodPeriodo
	   , CodCliente
	   , COALESCE([1],0)  impObjetivo_1
	   , COALESCE([2],0) impObjetivo_2
	   , COALESCE([3],0) impObjetivo_3
	   , COALESCE([4],0) impObjetivo_4
	   , COALESCE([5],0) impObjetivo_5
	   , COALESCE([6],0) impObjetivo_6
	   , COALESCE([7],0) impObjetivo_7
	   , COALESCE([8],0) impObjetivo_8
	   , COALESCE([9],0) impObjetivo_9
	   , COALESCE([10],0) impObjetivo_10
	   , COALESCE([11],0) impObjetivo_11
	   , COALESCE([12],0) impObjetivo_12
    FROM (SELECT CodEmpresa, CodCliente, Año, Mes,
		  FactCafe
		FROM [sym_rpt_vObjetivosInacatalog]
		) AS tt1
    PIVOT( SUM(FactCafe)
	   FOR Mes IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS tt2
    )
    INSERT INTO  sym_iObjetivosLin
    (codEmpresa
	, codPeriodo
	, datPaisDirCli
	, codCatalogo
	, codFamilia
	, codSubFamilia
	, codCliente
	, linDirCli
	, impObjetivo_1
	, cantObjetivo_1
	, impObjetivo_2
	, cantObjetivo_2
	, impObjetivo_3
	, cantObjetivo_3
	, impObjetivo_4
	, cantObjetivo_4
	, impObjetivo_5
	, cantObjetivo_5
	, impObjetivo_6
	, cantObjetivo_6
	, impObjetivo_7
	, cantObjetivo_7
	, impObjetivo_8
	, cantObjetivo_8
	, impObjetivo_9
	, cantObjetivo_9
	, impObjetivo_10
	, cantObjetivo_10
	, impObjetivo_11
	, cantObjetivo_11
	, impObjetivo_12
	, cantObjetivo_12)
    SELECT t1.CodEmpresa
	   , t1.codPeriodo
	   , 'ES' datPaisdirCli
	   , 2100 codCatalogo
	   , 1 CodFamilia
	   , 0 CodSubFamilia
	   , t1.CodCliente
	   , 1 linDirCli
	   , t2.impObjetivo_1
	   , t1.cantObjetivo_1
	   , t2.impObjetivo_2
	   , t1.cantObjetivo_2
	   , t2.impObjetivo_3
	   , t1.cantObjetivo_3
	   , t2.impObjetivo_4
	   , t1.cantObjetivo_4
	   , t2.impObjetivo_5
	   , t1.cantObjetivo_5
	   , t2.impObjetivo_6
	   , t1.cantObjetivo_6
	   , t2.impObjetivo_7
	   , t1.cantObjetivo_7
	   , t2.impObjetivo_8
	   , t1.cantObjetivo_8
	   , t2.impObjetivo_9
	   , t1.cantObjetivo_9
	   , t2.impObjetivo_10
	   , t1.cantObjetivo_10
	   , t2.impObjetivo_11
	   , t1.cantObjetivo_11
	   , t2.impObjetivo_12
	   , t1.cantObjetivo_12
    FROM KilosCafe t1
    INNER JOIN ImporteCafe t2
	   ON t1.CodEmpresa=t2.CodEmpresa
		  AND t1.CodCliente=t2.CodCliente
		  and t1.CodPeriodo=t2.CodPeriodo

	-- Presupuesto de Complementos
    ;WITH ImporteComplementos AS
    (
    SELECT CodEmpresa
	   , Año CodPeriodo
	   , CodCliente
	   , COALESCE([1],0)  impObjetivo_1
	   , COALESCE([2],0) impObjetivo_2
	   , COALESCE([3],0) impObjetivo_3
	   , COALESCE([4],0) impObjetivo_4
	   , COALESCE([5],0) impObjetivo_5
	   , COALESCE([6],0) impObjetivo_6
	   , COALESCE([7],0) impObjetivo_7
	   , COALESCE([8],0) impObjetivo_8
	   , COALESCE([9],0) impObjetivo_9
	   , COALESCE([10],0) impObjetivo_10
	   , COALESCE([11],0) impObjetivo_11
	   , COALESCE([12],0) impObjetivo_12
    FROM (SELECT CodEmpresa, CodCliente, Año, Mes,
		  FactCompl
		FROM [sym_rpt_vObjetivosInacatalog]
		) AS tt1
    PIVOT( SUM(FactCompl)
	   FOR Mes IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS tt2
    )
    INSERT INTO  sym_iObjetivosLin
    (codEmpresa
	, codPeriodo
	, datPaisDirCli
	, codCatalogo
	, codFamilia
	, codSubFamilia
	, codCliente
	, linDirCli
	, impObjetivo_1
	, cantObjetivo_1
	, impObjetivo_2
	, cantObjetivo_2
	, impObjetivo_3
	, cantObjetivo_3
	, impObjetivo_4
	, cantObjetivo_4
	, impObjetivo_5
	, cantObjetivo_5
	, impObjetivo_6
	, cantObjetivo_6
	, impObjetivo_7
	, cantObjetivo_7
	, impObjetivo_8
	, cantObjetivo_8
	, impObjetivo_9
	, cantObjetivo_9
	, impObjetivo_10
	, cantObjetivo_10
	, impObjetivo_11
	, cantObjetivo_11
	, impObjetivo_12
	, cantObjetivo_12)
    SELECT t1.CodEmpresa
	   , t1.codPeriodo
	   , 'ES' datPaisdirCli
	   , 2100 codCatalogo
	   , 2 CodFamilia
	   , 0 CodSubFamilia
	   , t1.CodCliente
	   , 1 linDirCli
	   , t1.impObjetivo_1
	   , 0 cantObjetivo_1
	   , t1.impObjetivo_2
	   , 0 cantObjetivo_2
	   , t1.impObjetivo_3
	   , 0 cantObjetivo_3
	   , t1.impObjetivo_4
	   , 0 cantObjetivo_4
	   , t1.impObjetivo_5
	   , 0 cantObjetivo_5
	   , t1.impObjetivo_6
	   , 0 cantObjetivo_6
	   , t1.impObjetivo_7
	   , 0 cantObjetivo_7
	   , t1.impObjetivo_8
	   , 0 cantObjetivo_8
	   , t1.impObjetivo_9
	   , 0 cantObjetivo_9
	   , t1.impObjetivo_10
	   , 0 cantObjetivo_10
	   , t1.impObjetivo_11
	   , 0 cantObjetivo_11
	   , t1.impObjetivo_12
	   , 0 cantObjetivo_12
    FROM ImporteComplementos t1

    -- Presupuesto de PLV
    ;WITH ImportePLV AS
    (
    SELECT CodEmpresa
	   , Año CodPeriodo
	   , CodCliente
	   , COALESCE([1],0)  impObjetivo_1
	   , COALESCE([2],0) impObjetivo_2
	   , COALESCE([3],0) impObjetivo_3
	   , COALESCE([4],0) impObjetivo_4
	   , COALESCE([5],0) impObjetivo_5
	   , COALESCE([6],0) impObjetivo_6
	   , COALESCE([7],0) impObjetivo_7
	   , COALESCE([8],0) impObjetivo_8
	   , COALESCE([9],0) impObjetivo_9
	   , COALESCE([10],0) impObjetivo_10
	   , COALESCE([11],0) impObjetivo_11
	   , COALESCE([12],0) impObjetivo_12
    FROM (SELECT CodEmpresa, CodCliente, Año, Mes,
		  ImportePLV
		FROM [sym_rpt_vObjetivosInacatalog]
		) AS tt1
    PIVOT( SUM(ImportePLV)
	   FOR Mes IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS tt2
    )
    INSERT INTO  sym_iObjetivosLin
    (codEmpresa
	, codPeriodo
	, datPaisDirCli
	, codCatalogo
	, codFamilia
	, codSubFamilia
	, codCliente
	, linDirCli
	, impObjetivo_1
	, cantObjetivo_1
	, impObjetivo_2
	, cantObjetivo_2
	, impObjetivo_3
	, cantObjetivo_3
	, impObjetivo_4
	, cantObjetivo_4
	, impObjetivo_5
	, cantObjetivo_5
	, impObjetivo_6
	, cantObjetivo_6
	, impObjetivo_7
	, cantObjetivo_7
	, impObjetivo_8
	, cantObjetivo_8
	, impObjetivo_9
	, cantObjetivo_9
	, impObjetivo_10
	, cantObjetivo_10
	, impObjetivo_11
	, cantObjetivo_11
	, impObjetivo_12
	, cantObjetivo_12)
    SELECT t1.CodEmpresa
	   , t1.codPeriodo
	   , 'ES' datPaisdirCli
	   , 2100 codCatalogo
	   , 6 CodFamilia
	   , 0 CodSubFamilia
	   , t1.CodCliente
	   , 1 linDirCli
	   , t1.impObjetivo_1
	   , 0 cantObjetivo_1
	   , t1.impObjetivo_2
	   , 0 cantObjetivo_2
	   , t1.impObjetivo_3
	   , 0 cantObjetivo_3
	   , t1.impObjetivo_4
	   , 0 cantObjetivo_4
	   , t1.impObjetivo_5
	   , 0 cantObjetivo_5
	   , t1.impObjetivo_6
	   , 0 cantObjetivo_6
	   , t1.impObjetivo_7
	   , 0 cantObjetivo_7
	   , t1.impObjetivo_8
	   , 0 cantObjetivo_8
	   , t1.impObjetivo_9
	   , 0 cantObjetivo_9
	   , t1.impObjetivo_10
	   , 0 cantObjetivo_10
	   , t1.impObjetivo_11
	   , 0 cantObjetivo_11
	   , t1.impObjetivo_12
	   , 0 cantObjetivo_12
    FROM ImportePLV t1

    -- Llamar al sp de Inase
    exec inaSAM..[TOTAL_CargarObjetivosAPedidos]

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
