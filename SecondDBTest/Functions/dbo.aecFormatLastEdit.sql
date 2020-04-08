SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [aecFormatLastEdit](@strUserCode NVARCHAR(20), @dtDate DATETIME) RETURNS NVARCHAR(30)
AS
BEGIN
    DECLARE @strLastEdit NVARCHAR(40);

	-- TODO: do this properly
	SET @strLastEdit = @strUserCode + ' ' + 
						CONVERT(NVARCHAR, @dtDate - 2, 103) + ' ' + 
						SUBSTRING(CONVERT(NVARCHAR, @dtDate, 114), 1, 5)

	SET @strLastEdit = SUBSTRING(@strLastEdit, 1, 30)

	RETURN(@strLastEdit);
END;

GO
