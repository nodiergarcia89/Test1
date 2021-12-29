SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================
-- Author:		Ramon Villanueva
-- Create date: 19/02/2015
-- Description:	TAM (365 dias atras)
-- Se utiliza para saber la fecha desde para la extraccion de datos
-- =====================================================================
CREATE FUNCTION [dbo].[ufDiasAtras] ()
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result date

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = dateadd(d,-365,getdate())

	-- Return the result of the function
	RETURN @Result

END
GO
