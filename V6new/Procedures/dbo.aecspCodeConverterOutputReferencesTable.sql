SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

--Create the Stored Procedure
CREATE PROCEDURE [aecspCodeConverterOutputReferencesTable](@primaryTable AS NVARCHAR(30)) AS

--Turn off the rows affected messages
SET NOCOUNT ON 

--Create the temporary table
CREATE TABLE #CodeConverterTableReferences
(
FK_Table		NVARCHAR(30) COLLATE database_default,
FK_Column		NVARCHAR(30) COLLATE database_default,
UP_Code			NVARCHAR(250) COLLATE database_default
)

--Populate the Table References table for the specified table
EXEC aecspCodeConverterPopulateReferencesTable @primaryTable;

--Output the contents of the References Table
SELECT * FROM #CodeConverterTableReferences

--Drop the temporary table
DROP TABLE #CodeConverterTableReferences

--Turn on the rows affected messages
SET NOCOUNT OFF 


GO
GRANT EXECUTE
	ON [dbo].[aecspCodeConverterOutputReferencesTable]
	TO [V6N14816rwZf]
GO
