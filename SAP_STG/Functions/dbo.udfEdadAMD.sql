SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 23/12/2015
-- Description:	Edad en años, meses y dias
-- =============================================
CREATE FUNCTION [dbo].[udfEdadAMD] 
(
	-- Add the parameters for the function here
	@Id nvarchar(150),
	@Fecha datetime
)
RETURNS @Result table(Id nvarchar(150), Años int, Meses int, Dias int)
AS
begin
	
	-- Add the T-SQL statements to compute the return value here
	DECLARE @tmpdate datetime, @years int, @months int, @days int

	SELECT @tmpdate = @Fecha

	SELECT @years = DATEDIFF(yy, @tmpdate, GETDATE()) - CASE WHEN (MONTH(@Fecha) > MONTH(GETDATE())) OR (MONTH(@Fecha) = MONTH(GETDATE()) AND DAY(@Fecha) > DAY(GETDATE())) THEN 1 ELSE 0 END
	SELECT @tmpdate = DATEADD(yy, @years, @tmpdate)
	SELECT @months = DATEDIFF(m, @tmpdate, GETDATE()) - CASE WHEN DAY(@Fecha) > DAY(GETDATE()) THEN 1 ELSE 0 END
	SELECT @tmpdate = DATEADD(m, @months, @tmpdate)
	SELECT @days = DATEDIFF(d, @tmpdate, GETDATE())

	insert into @Result
		SELECT @Id, @years, @months, @days

	RETURN

END
GO
