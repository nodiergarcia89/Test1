SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 14/06/2013
-- Description:	Devolver SAAMMDD desde AAAAMMDD
-- =============================================
CREATE FUNCTION [dbo].[ufGetSAAMMDD_AAAAMMDD] 
(
	-- Add the parameters for the function here
	@Fecha char(8)
)
RETURNS char(7)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result char(7)

	-- Convertir fecha a SAAMMDD
	select @Result=(CASE 
		WHEN SUBSTRING(@Fecha,1,1) = 2 
			THEN '1'+ SUBSTRING(@Fecha,3,6)
		ELSE '0' + SUBSTRING(@Fecha,3,6)
	END)

	-- Return the result of the function
	RETURN @Result

END

GO
