SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================
-- Author:	 Ramon Villanueva
-- Create date: 29/05/2020
-- Description: B2B. Acceso de los clientes a la plataforma
-- ============================================================
CREATE PROCEDURE [dbo].[uspB2BClientesPlataforma]
AS
    BEGIN
	   -- Acceso del cliente a la plataforma - inaSAP.dbo.iClientesCredenciales
	   DELETE sym_iClientesCredenciales
	   INSERT INTO sym_iClientesCredenciales
	   SELECT 
			t1.codEmpresa
		   , t1.codCliente
		   , t1.datLogin
		   , t1.datPassword
		   , ''
	   FROM     sym_par_inaClientes AS t1
	   WHERE   t1.Ina = 1
			-- AND RIGHT(t1.CodCliente, 4) <> 'Test'
	  -- UNION ALL
	  -- SELECT 
			--t1.codEmpresa
		 --  , t1.codCliente
		 --  , CONCAT(t1.datLogin, 'Test') AS datLogin
		 --  , t1.datPassword
		 --  , ''
	  -- FROM   sym_par_inaClientes AS t1
	  -- WHERE  t1.Ina = 1
			--AND RIGHT(t1.CodCliente, 4) = 'Test'
	   -- Direcciones de email para la rrecuperacion de la contraseña
	   DELETE sym_iClientesMailB2B
	   INSERT INTO sym_iClientesMailB2B
	   SELECT 
			t1.codEmpresa
		   , t1.codCliente
		   , t1.email
	   FROM   sym_par_inaClientes AS t1
	   WHERE  t1.Ina = 1
			--AND RIGHT(t1.CodCliente, 4) <> 'Test'
    END
GO
