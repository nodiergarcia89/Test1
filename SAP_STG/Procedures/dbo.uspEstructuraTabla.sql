SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 12/12/2014
-- Description:	Devolver estructura de tabla
-- =============================================
CREATE PROCEDURE [dbo].[uspEstructuraTabla] 
	-- Add the parameters for the stored procedure here
	@table1  NVARCHAR(255) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT C.object_id, C.column_id, C.name as column_name, T.name as type_name, C.max_length, C.precision
        FROM sys.columns C
             INNER JOIN sys.types T 
				ON C.user_type_id=T.user_type_id
		WHERE object_id = OBJECT_ID(@table1)
		order by column_id
END
GO
