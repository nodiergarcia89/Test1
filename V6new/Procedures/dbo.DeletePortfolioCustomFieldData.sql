SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


Create Procedure DeletePortfolioCustomFieldData
	@PSCKey int
AS
	-----Delete Custom Fields ---------


DECLARE @TableCount int;
DECLARE @Counter int;
DECLARE @name nvarchar(70);
DECLARE @sql nvarchar(4000);

-- Project Number Custom Fields
Select @TableCount = CT_Num FROM CustomTables WHERE CT_Table = 1001;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'PortfolioProjectCustomNum' + CAST(@Counter as char);

		SET @sql = 'DELETE ' +RTRIM(@name) + '   
					WHERE EXISTS (SELECT 1 
									FROM PortfolioScenarioForecast PSF
									WHERE PSF.PSF_Key = ' + RTRIM(@name) + '.PSF_Key
											AND PSF.PSC_Key = ' +cast(@PSCKey as char) +'
								)';
		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;

-- Project Number Custom Fields
Select @TableCount = CT_STxt FROM CustomTables WHERE CT_Table = 1001;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'PortfolioProjectCustomSTxt' + CAST(@Counter as char);

		SET @sql = 'DELETE ' +RTRIM(@name) + '   
					WHERE EXISTS (SELECT 1 
									FROM PortfolioScenarioForecast PSF
									WHERE PSF.PSF_Key = ' + RTRIM(@name) + '.PSF_Key
											AND PSF.PSC_Key = ' +cast(@PSCKey as char) +'
								)';
		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;

-- Profile Num Custom Fields
Select @TableCount = CT_Num FROM CustomTables WHERE CT_Table = 1019;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'PortfolioProfileCustomNum' + CAST(@Counter as char);

		SET @sql = 'DELETE ' + RTRIM(@name) + '  
					WHERE EXISTS (SELECT 1 
						FROM PortfolioScenarioForecast PSF 
						WHERE PSF.PSF_Key = ' + RTRIM(@name) + '.PSF_Key
								AND PSF.PSC_Key = ' +cast(@PSCKey as char) +'
					)';
					
		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;
	
-- Profile STxt Custom Fields
Select @TableCount = CT_STxt FROM CustomTables WHERE CT_Table = 1019;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'PortfolioProfileCustomSTxt' + CAST(@Counter as char);

		SET @sql = 'DELETE ' + RTRIM(@name) + '  
					WHERE EXISTS (SELECT 1 
						FROM PortfolioScenarioForecast PSF 
						WHERE PSF.PSF_Key = ' + RTRIM(@name) + '.PSF_Key
								AND PSF.PSC_Key = ' +cast(@PSCKey as char) +'
					)';
					
		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;	
GO
GRANT EXECUTE
	ON [dbo].[DeletePortfolioCustomFieldData]
	TO [V6N14816rwZf]
GO
