SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date:	06/04/2020
-- Description:	Convertir reportes a HTML
--      Convertir a HTML reportes 108,120,121,122
-- ========================================================================
CREATE   PROCEDURE [dbo].[usp_inaConvReportesHTML] AS
BEGIN
	SET NOCOUNT ON;

	UPDATE sym_iReportesLin 
--	   SET datRespuesta='<html>' + REPLACE(CHAR(13)+CHAR(10),t1.datRespuesta,'<br>') + '</html>'
	   SET datRespuesta=REPLACE(CHAR(13)+CHAR(10),t1.datRespuesta,'<br>')
	   	FROM sym_iReportesLin t1
		  INNER JOIN sym_iPlantillaReportesLin t2
			 on t1.CodEmpresa=t2.CodEmpresa
				and t1.codPlantillaReportes=t2.codPlantillaReportes
				and t1.linReportesLin=linPlantillaReportesLin
				and t2.codtipoCampo='H'
		WHERE t1.codPlantillaReportes IN(108,120,121,122)
END
GO
