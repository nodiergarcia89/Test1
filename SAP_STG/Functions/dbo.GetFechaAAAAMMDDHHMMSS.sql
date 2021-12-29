SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




-- GetFechaAAAAMMDDHHMMSS
CREATE   function [dbo].[GetFechaAAAAMMDDHHMMSS](@Fecha as varchar(14))
RETURNS datetime
As
Begin
	return CONVERT(DATETIME, STUFF(STUFF(STUFF(@Fecha, 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) 
end




GO
