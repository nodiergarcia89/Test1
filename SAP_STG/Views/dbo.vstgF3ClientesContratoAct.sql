SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 29/06/2015
-- Description:	Clientes con contrato activo hoy
-- ========================================================
CREATE view [dbo].[vstgF3ClientesContratoAct] as
SELECT *
FROM
(SELECT *
        , row_number () over (partition by CodCliente order by CodCliente, NumContrato desc) AS RowN
   FROM vstgF2ClientesContratoAct) as T
WHERE RowN = 1
GO
