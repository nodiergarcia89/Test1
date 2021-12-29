SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[RecordCount]   
  @TableName nvarchar(128),
  @Count int OUTPUT
AS 
BEGIN
  DECLARE @SQLString nvarchar(500); 
  DECLARE @ParamDefinition nvarchar(500); 
  
  SET @SQLString = 'SELECT @Count = Count(*) FROM '+@TableName 
  SET @ParamDefinition = '@Count int OUTPUT' 
  
EXECUTE sys.sp_executesql @SQLString, @ParamDefinition, @Count output 
END
GO
