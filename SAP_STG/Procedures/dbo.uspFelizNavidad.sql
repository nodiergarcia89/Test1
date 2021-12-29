SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 23/12/2015
-- Description:	Feliz Navidad
-- =============================================
CREATE PROCEDURE [dbo].[uspFelizNavidad] 
	@Usuario as nvarchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set language spanish

	select *
	from vFechaAntiguedad
	where username=@Usuario

END
GO
