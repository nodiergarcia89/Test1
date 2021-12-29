SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 16/09/2013
-- Description:	Devolver tabla de valores a partir
-- de un parametro con la cadena y otro con el 
-- delimitador
-- =============================================

CREATE FUNCTION [dbo].[ufnDelimitedVarCharToTable]
(
@List varchar(max), @Delimiter varchar(10)
)
RETURNS @Ids TABLE
(Id varchar(max)) AS
BEGIN
DECLARE @list1 VARCHAR(MAX), @Pos INT, @rList VARCHAR(MAX)
SET @List = LTRIM(RTRIM(@List)) + @Delimiter
SET @pos = CHARINDEX(@Delimiter, @List, 1)
WHILE @pos > 0
    BEGIN
    SET @list1 = LTRIM(RTRIM(LEFT(@List, @pos - 1)))
    IF @list1 <> ''
        INSERT INTO @Ids(Id) VALUES (CAST(@list1 AS varchar(max)))
    SET @List = SUBSTRING(@List, @pos+1, LEN(@List))
    SET @pos = CHARINDEX(@Delimiter, @list, 1)
END
RETURN 
END
GO
