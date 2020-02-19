SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
--JS2e

-- PR3s
CREATE FUNCTION	CalculatePeriodDate(@periodType int, @periodDate as float, @startMonth as int)
RETURNS float 
AS
BEGIN
	DECLARE @retVal float;
	DECLARE @tempDate as DateTime;
	DECLARE @year as Integer;
	DECLARE @month as Integer;

	DECLARE @gotValue as TinyInt;
	DECLARE @monthCounter as Integer;
	DECLARE @quarterMonth as Integer;
	DECLARE @quarterStart as Integer;
	DECLARE @dateString as VarChar(8);

	SET @tempDate = Cast(@periodDate -2 as DateTime);
	SET @year = DATEPART(Year, @tempDate);
	SET @month = DATEPART(Month, @tempDate);
	SET @gotValue = 0;
	

	IF (@periodType <= 3) 
		--Weeks/Months
		return @periodDate;
	--Quarters
	ELSE IF(@periodType = 4)
		BEGIN
			--Set initial value
			SET @quarterStart = @startMonth;
			SET @quarterMonth = @startMonth;
			SET @monthCounter = 1;

			WHILE (@gotValue = 0)
				BEGIN
					if @quarterMonth = @month
						BEGIN
							--If current month is equal to month of the passed in date then we have got the correct quarter
							SET @gotValue = 1;
						END;
					ELSE
						BEGIN
							if @quarterMonth = 12 
								BEGIN
									--Gone past year end so set to Jan
									SET @quarterMonth = 1;														
								END;
							ELSE	
								BEGIN
									--Advance to next month
									SET @quarterMonth = @quarterMonth + 1;
								END;

							if @monthCounter = 3 
								BEGIN
									--End of quarter so set next quarter value
									SET @monthCounter = 1;
									SET @quarterStart = @quarterMonth
								END;
							ELSE	
								BEGIN
									--Still in current quarter to increase counter
									SET @monthCounter = @monthCounter + 1;
								END;
						END;
				END;

			-- Set the Month so that it will get used in the return below
			SET @month = @quarterStart;			
			--SET @startMonth = @quarterStart;
		END
	ELSE IF(@periodType = 5)
		BEGIN
			if(@month < @startMonth)
				BEGIN
					SET @year = @year - 1;
				END
			 -- Set this so that it returns the first month of the Financial Year
			 SET @month = @startMonth;
		END;

     IF (@periodType = 4 AND ((@startMonth = 11 AND DATEPART(Month, @tempDate) <= 1) OR (@startMonth = 12 AND DATEPART(Month, @tempDate) <= 2)))
	   BEGIN
		  SET @dateString = cast(@year-1 as varchar);
	   END
	   ELSE
	   BEGIN
		  SET @dateString = cast(@year as varchar);
	   END
	   	
	SET @dateString = @dateString + RIGHT(REPLICATE('0', 2) + cast(@month as varchar), 2);
	SET @dateString = @dateString + '01';

	SET @retVal = cast(CONVERT(dateTime, @dateString, 120) + 2 as float);

	return @retVal;	
END;

--PR3e
GO
GRANT EXECUTE
	ON [dbo].[CalculatePeriodDate]
	TO [V6N14816rwZf]
GO
