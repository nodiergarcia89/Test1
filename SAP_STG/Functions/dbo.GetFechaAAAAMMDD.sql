SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- GetFechaAAAAMMDD
create function [dbo].[GetFechaAAAAMMDD](@Fecha as varchar(8))
RETURNS smalldatetime
As
Begin
	declare @y int
	declare @m int
	declare @d int

	if @y >2030 select @y=2030

	-- Descomponer en AAAA, MM y DD
	Select @y=SUBSTRING(@Fecha, 1, 4)
	Select @m=SUBSTRING(@Fecha, 5, 2)
	Select @d=SUBSTRING(@Fecha, 7, 2)

	-- with date string. Format is forced (120) to prevent internationalization issues
	return CONVERT(smalldatetime, CONVERT(varchar(4), @y) + '-' + CONVERT(varchar(2), @m) + '-' + CONVERT(varchar(2), @d), 120)
	-- with pure date arithmetics:
	-- Return DATEADD(dd, @d-1, DATEADD(mm, @m-1, DATEADD(yy, @y-1900, 0)))
	-- Return convert(smalldatetime, (substring(convert(char(8),@Fecha),7,2) + '/' + substring(convert(char(8),@Fecha),5,2) + '/' + substring(convert(char(8),@Fecha),1,4)))
end




GO
