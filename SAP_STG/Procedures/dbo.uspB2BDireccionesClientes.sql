SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================
-- Author:	 Ramon Villanueva
-- Create date: 10/11/2020
-- Description: Consulta de direcciones de clientes a tabla por
--	problemas de rendimiento en carga del B2B
-- Modificacion: 18/02/2021
--   Aunque paso las direcciones de envio, respeto linDirCli para
-- que los pedidos vengan bien. Lo he probado con RA y es OK 
-- ==============================================================
CREATE PROCEDURE [dbo].[uspB2BDireccionesClientes] AS
BEGIN
    -- Borrar tabla de direcciones
    DELETE FROM inaSAM.dbo.iClientesLDirPersoTmp;

    -- Insertar registros
    WITH Direcciones
	    AS (SELECT 
				c.CodEmpresa
			   , c.CodCliente
			   , c.linDirCli
			   , ROW_NUMBER() OVER(PARTITION BY c.CodEmpresa
									    , c.CodCliente
				ORDER BY 
					    c.linDirCli) AS RowNum
		   FROM   SAP_STG.dbo.vIna_iClientesLDir_alt AS c  -- Sólo direcciones de envío
				INNER JOIN InaSAP.par.inaClientes AS T -- Solo cliente Web
				  ON c.CodEmpresa = T.codEmpresa
					AND CONVERT(NVARCHAR, c.codCliente) = T.codCliente
					AND T.Ina = 1)
	    INSERT INTO inaSAM.dbo.iClientesLDirPersoTmp
	    SELECT 
			 c.codEmpresa
		    , CONVERT(NVARCHAR, c.codCliente) AS         CodCliente
		    --, T.RowNum AS                                linDirCli -- 09/12/20 Me aseguro que existe el codigo de direccion 1
		    , T.linDirCli AS                                linDirCli -- 18/02/21
		    , c.nomDirCli
		    , c.rsoDirCli
		    , c.datCalleDirCli
		    , c.codPostalDirCli
		    , c.datPoblacionDirCli
		    , c.datProvinciaDirCli
		    , c.datPaisDirCli
		    , c.datContactoDirCli
		    , c.datTelefonoDirCli
		    , c.datFaxDirCli
		    , ISNULL(M.datemailweb, c.datEmailDirCli) AS datEmailDirCli
		    , c.hipWebDirCli
		    , c.codSuDirCli
		    , c.valLatitud
		    , c.valLongitud
		    , c.datTelMovilDirCli
		    , c.codAgente
		    , c.flaNvoDirCli
	    FROM   SAP_STG.dbo.vIna_iClientesLDir_alt AS c  -- Sólo direcciones de envío
			 LEFT JOIN InaSAP.dbo.iClientesMailB2B AS M
			   ON M.codEmpresa = C.codEmpresa
				 AND M.codCliente = CONVERT(NVARCHAR, C.codCliente)
			 INNER JOIN Direcciones AS T
			   ON c.CodEmpresa = T.codEmpresa
				 AND CONVERT(NVARCHAR, c.codCliente) = T.codCliente
				 AND c.linDirCli = t.linDirCli
END
GO
