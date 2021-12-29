SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================
-- Author:	 Ramon Villanueva
-- Create date: 29/05/2020
-- Description: B2B. Acceso de los clientes a los catalogos
-- ============================================================
CREATE PROCEDURE [dbo].[uspB2BClientesCatalogo]
AS
    BEGIN
	   DELETE sym_iClientesLCatB2B
	   DELETE sym_iAgentesLMails

	   -- Clientes del catalogo - inaSAP.dbo.iClientesLCatB2B
	   INSERT INTO sym_iClientesLCatB2B
	   SELECT 
			t1.codEmpresa
		   , t1.codCliente
		   , t1.codCliente AS codCatalogo
		   , t1.Ina AS        flaWeb
	   FROM   sym_par_inaClientes AS t1
	   WHERE  t1.Ina = 1

	   -- Catalogo de complementos
	   INSERT INTO sym_iClientesLCatB2B
	   SELECT 
			t1.codEmpresa
		   , t1.codCliente
		   , 'COMPLEMENTOS' AS codCatalogo
		   , t1.Ina AS         flaWeb
	   FROM   sym_par_inaClientes AS t1
	   WHERE  t1.Ina = 1
			AND CatComplementos = 1

	   -- Catalogo de Multimedia
	   INSERT INTO sym_iClientesLCatB2B
	   SELECT 
			t1.codEmpresa
		   , t1.codCliente
		   , 'MULTIMEDIA' AS codCatalogo
		   , t1.Ina AS       flaWeb
	   FROM   sym_par_inaClientes AS t1
	   WHERE  t1.Ina = 1

	   -- Tipos Multmimedia para el pie Footer
	   DELETE sym_iTiposMultimedia
	   WHERE  
		    linMultimedia = 99
	   INSERT INTO sym_iTiposMultimedia
	   SELECT 
			t1.codEmpresa
		   , t1.codCliente
		   , '99' AS          linMultimedia
		   , 'Condiciones' AS Tipo
	   FROM   sym_par_inaClientes AS t1
	   WHERE  t1.Ina = 1

	   -- Emails de agentes responsables para notificacion;
	   ;WITH AgentesRespCuenta
		   AS (SELECT DISTINCT 
				    t1.codEmpresa
				  , t2.CodAgente
			  FROM   sym_par_inaClientes AS t1
				    INNER JOIN dbo.sym_iClientes AS t2
					 ON t1.codEmpresa = t2.codEmpresa
					    AND CONVERT(NVARCHAR, t1.codCliente) = t2.codCliente)
		   INSERT INTO sym_iAgentesLMails
				(
				codEmpresa
			   , codAgente
			   , datMail
				)
		   SELECT DISTINCT 
				t1.codEmpresa
			   , t1.CodAgente
			   , CONCAT(TRIM(t3.Email), ',Raquel.Arambarri@cafestemplo.es') AS Email   -----| De momento se notifica tambien a Raquel
		   FROM   AgentesRespCuenta AS t1
				LEFT JOIN stgF2Vendedores AS t3
				  ON t1.codEmpresa = t3.codEmpresa
					AND t1.CodAgente = t3.CodVendedor
    END
GO
