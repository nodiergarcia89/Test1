SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


Create Procedure PopulatePortfolioCustomFieldData
	@PFLKey int
AS

-- Creates the Project and Profile custom field data for a given portfolio based on its selected projects and forecasts.

-----Generate Custom Fields ---------

DECLARE @TableCount int;
DECLARE @Counter int;
DECLARE @name nvarchar(70);
DECLARE @sql nvarchar(4000);

--Project Number Custom Fields
Select @TableCount = CT_Num FROM CustomTables WHERE CT_Table = 1001;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'ProjectCustomNum' + CAST(@Counter as char);

		SET @sql = 'INSERT INTO Portfolio' + RTRIM(@name) + '   
				SELECT distinct PSF_Key, CU_Value1 ,CU_Value2 ,CU_Value3 ,CU_Value4 ,CU_Value5 ,CU_Value6 ,CU_Value7 ,CU_Value8 ,CU_Value9 ,CU_Value10
				,CU_Value11 ,CU_Value12 ,CU_Value13 ,CU_Value14 ,CU_Value15 ,CU_Value16 ,CU_Value17 ,CU_Value18 ,CU_Value19 ,CU_Value20 
				,CU_Value21 ,CU_Value22 ,CU_Value23 ,CU_Value24 ,CU_Value25 ,CU_Value26 ,CU_Value27 ,CU_Value28 ,CU_Value29 ,CU_Value30
				,CU_Value31 ,CU_Value32 ,CU_Value33 ,CU_Value34 ,CU_Value35 ,CU_Value36 ,CU_Value37 ,CU_Value38 ,CU_Value39 ,CU_Value40
				,CU_Value41 ,CU_Value42 ,CU_Value43 ,CU_Value44 ,CU_Value45 ,CU_Value46 ,CU_Value47 ,CU_Value48 ,CU_Value49 ,CU_Value50
				from ' + RTRIM(@name) + '
						Join PortfolioProjects PP
							on PP.PR_Code = ' + RTRIM(@name) + '.PR_Code
						join PortfolioForecasts PFO
							on PFO.PPR_Key = PP.PPR_Key
						join PortfolioScenarioForecast PF
							on PF.PFO_Key = PFO.PFO_Key 
				WHERE PFO.PFL_Key = ' + CAST(@PFLKey as char);
		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;

--Project STxt Custom Fields
Select @TableCount = CT_STxt FROM CustomTables WHERE CT_Table = 1001;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'ProjectCustomSTxt' + CAST(@Counter as char);

		SET @sql = 'INSERT INTO Portfolio' + RTRIM(@name) + '   
				SELECT distinct PSF_Key, CU_Value1 ,CU_Value2 ,CU_Value3 ,CU_Value4 ,CU_Value5 ,CU_Value6 ,CU_Value7 ,CU_Value8 ,CU_Value9 ,CU_Value10
				,CU_Value11 ,CU_Value12 ,CU_Value13 ,CU_Value14 ,CU_Value15 ,CU_Value16 ,CU_Value17 ,CU_Value18 ,CU_Value19 ,CU_Value20 
				,CU_Value21 ,CU_Value22 ,CU_Value23 ,CU_Value24 ,CU_Value25 ,CU_Value26 ,CU_Value27 ,CU_Value28 ,CU_Value29 ,CU_Value30
				,CU_Value31 ,CU_Value32 ,CU_Value33 ,CU_Value34 ,CU_Value35 ,CU_Value36 ,CU_Value37 ,CU_Value38 ,CU_Value39 ,CU_Value40
				,CU_Value41 ,CU_Value42 ,CU_Value43 ,CU_Value44 ,CU_Value45 ,CU_Value46 ,CU_Value47 ,CU_Value48 ,CU_Value49 ,CU_Value50
				from ' + RTRIM(@name) + '
						Join PortfolioProjects PP
							on PP.PR_Code = ' + RTRIM(@name) + '.PR_Code
						join PortfolioForecasts PFO
							on PFO.PPR_Key = PP.PPR_Key
						join PortfolioScenarioForecast PF
							on PF.PFO_Key = PFO.PFO_Key 
				WHERE PFO.PFL_Key = ' + CAST(@PFLKey as char);
		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;

--Profile Number Custom Fields
Select @TableCount = CT_Num FROM CustomTables WHERE CT_Table = 1019;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'ProfileCustomNum' + CAST(@Counter as char);

		SET @sql = 'INSERT INTO Portfolio' + RTRIM(@name) + '  
				SELECT PSF_Key, CU_Value1 ,CU_Value2 ,CU_Value3 ,CU_Value4 ,CU_Value5 ,CU_Value6 ,CU_Value7 ,CU_Value8 ,CU_Value9 ,CU_Value10
				,CU_Value11 ,CU_Value12 ,CU_Value13 ,CU_Value14 ,CU_Value15 ,CU_Value16 ,CU_Value17 ,CU_Value18 ,CU_Value19 ,CU_Value20 
				,CU_Value21 ,CU_Value22 ,CU_Value23 ,CU_Value24 ,CU_Value25 ,CU_Value26 ,CU_Value27 ,CU_Value28 ,CU_Value29 ,CU_Value30
				,CU_Value31 ,CU_Value32 ,CU_Value33 ,CU_Value34 ,CU_Value35 ,CU_Value36 ,CU_Value37 ,CU_Value38 ,CU_Value39 ,CU_Value40
				,CU_Value41 ,CU_Value42 ,CU_Value43 ,CU_Value44 ,CU_Value45 ,CU_Value46 ,CU_Value47 ,CU_Value48 ,CU_Value49 ,CU_Value50
				from ' + RTRIM(@name) + '
					Join PortfolioForecasts PF
						on PF.PFO_ProfileKey = ' + RTRIM(@name) + '.PRF_Key
					join PortfolioScenarioForecast PFS
						on PF.PFO_Key = PFS.PFO_Key
				WHERE PF.PFL_Key = ' + CAST(@PFLKey as char);

		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;
	
--Profile STxt Custom Fields
Select @TableCount = CT_STxt FROM CustomTables WHERE CT_Table = 1019;
SET @Counter = 1;

	WHILE @Counter <= @TableCount
	BEGIN
	
		SET @name = 'ProfileCustomSTxt' + CAST(@Counter as char);

		SET @sql = 'INSERT INTO Portfolio' + RTRIM(@name) + '  
				SELECT PSF_Key, CU_Value1 ,CU_Value2 ,CU_Value3 ,CU_Value4 ,CU_Value5 ,CU_Value6 ,CU_Value7 ,CU_Value8 ,CU_Value9 ,CU_Value10
				,CU_Value11 ,CU_Value12 ,CU_Value13 ,CU_Value14 ,CU_Value15 ,CU_Value16 ,CU_Value17 ,CU_Value18 ,CU_Value19 ,CU_Value20 
				,CU_Value21 ,CU_Value22 ,CU_Value23 ,CU_Value24 ,CU_Value25 ,CU_Value26 ,CU_Value27 ,CU_Value28 ,CU_Value29 ,CU_Value30
				,CU_Value31 ,CU_Value32 ,CU_Value33 ,CU_Value34 ,CU_Value35 ,CU_Value36 ,CU_Value37 ,CU_Value38 ,CU_Value39 ,CU_Value40
				,CU_Value41 ,CU_Value42 ,CU_Value43 ,CU_Value44 ,CU_Value45 ,CU_Value46 ,CU_Value47 ,CU_Value48 ,CU_Value49 ,CU_Value50
				from ' + RTRIM(@name) + '
					Join PortfolioForecasts PF
						on PF.PFO_ProfileKey = ' + RTRIM(@name) + '.PRF_Key
					join PortfolioScenarioForecast PFS
						on PF.PFO_Key = PFS.PFO_Key
				WHERE PF.PFL_Key = ' + CAST(@PFLKey as char);

		EXEC(@sql);

		set @Counter = @Counter + 1;
	END;	
GO
