SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO







CREATE Function [dbo].[udf_DT_YearStart](@Year As Integer) 
RETURNS DATETIME
AS
BEGIN

Declare  @WeekDay As Integer
	,@NewYear As DateTIME
	,@YearStart as datetime 

set @NewYear = Cast((Cast(@Year as varchar(4))+'-01-01') as datetime)
set @WeekDay =  (datepart(dw, dateadd(d, -2 , @NewYear)))%7

If @WeekDay < 4 
    set @YearStart = dateadd(d,  - @WeekDay, @NewYear)
Else
    set @YearStart = dateadd(d,  7- @WeekDay , @NewYear)

return @YearStart

End 








GO
