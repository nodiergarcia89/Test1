SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION kipCustomFieldTables (@entityName NVARCHAR(30), @tableType INT)  
RETURNS @EntityCustomTables TABLE   
(      
    CT_TableName nvarchar(100) NOT NULL   
)  

AS  
BEGIN  

	DECLARE @intNumTables AS INTEGER;
	DECLARE @intSTxtTables AS INTEGER;
	DECLARE @intTxtTables AS INTEGER;
	DECLARE @intTable AS INTEGER;
	DECLARE @strEntityTableNamePrefix AS NVARCHAR(100)	

	--Validate Entity?
	SET @strEntityTableNamePrefix = @entityName;

	-- Select Table names for entity
	SELECT
		@intNumTables = CustomTables.CT_Num,
		@intSTxtTables = CustomTables.CT_STxt,
		@intTxtTables = CustomTables.CT_Txt
	FROM CustomTables
	WHERE CustomTables.CT_Table = @tableType;

	SET @intTable = 1;
	WHILE (@intTable <= @intNumTables)
	BEGIN
		
		INSERT INTO @EntityCustomTables (CT_TableName) VALUES (
				@strEntityTableNamePrefix + 'CustomNum' + CAST(@intTable AS NVARCHAR));		

		SET @intTable = @intTable + 1;
	END

	SET @intTable = 1;
	WHILE (@intTable <= @intSTxtTables)
	BEGIN
		
		INSERT INTO @EntityCustomTables (CT_TableName) VALUES (
				@strEntityTableNamePrefix + 'CustomSTxt' + CAST(@intTable AS NVARCHAR));

		SET @intTable = @intTable + 1;
	END

	SET @intTable = 1;
	WHILE (@intTable <= @intTxtTables)
	BEGIN
		
		INSERT INTO @EntityCustomTables (CT_TableName) VALUES (
				@strEntityTableNamePrefix + 'CustomTxt' + CAST(@intTable AS NVARCHAR));

		SET @intTable = @intTable + 1;
	END

	   RETURN  
END;  
GO
GRANT SELECT
	ON [dbo].[kipCustomFieldTables]
	TO [V6N14816rwZf]
GO
