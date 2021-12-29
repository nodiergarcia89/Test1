SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



create  FUNCTION [dbo].[udf_DT_ISOWeekNum]
(@AnyDate   Datetime )
RETURNS int
AS


BEGIN
Declare  @ThisYear   		Int 
	,@PreviousYearStart  	Datetime
	,@ThisYearStart   	Datetime
	,@NextYearStart  	Datetime
	,@YearNum  		Int
	,@ISOWeekNum 		int
	,@str			varchar(25)

Set @ThisYear = Year(@AnyDate)
Set @ThisYearStart = dbo.udf_DT_YearStart(@ThisYear)
Set @PreviousYearStart = dbo.udf_DT_YearStart(@ThisYear - 1)
Set @NextYearStart = dbo.udf_DT_YearStart(@ThisYear + 1)


If @AnyDate >= @NextYearStart  
	Begin
		set @ISOWeekNum = Datediff(d,@NextYearStart, @AnyDate)/7 + 1
		set @YearNum = Year(@AnyDate) + 1
	End
If  @AnyDate  < @ThisYearStart  
	begin
		set  @ISOWeekNum = Datediff(d, @PreviousYearStart,@AnyDate)/7 + 1
		set  @YearNum = Year(@AnyDate) - 1
	end
    Else
	begin
	       set @ISOWeekNum = Datediff(d,@ThisYearStart,@AnyDate)/7 + 1
	       set @YearNum = Year(@AnyDate)
	End 

Return @ISOWeekNum 

return @str

End














GO
