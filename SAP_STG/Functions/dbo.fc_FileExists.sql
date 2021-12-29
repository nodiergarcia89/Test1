SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[fc_FileExists](@path varchar(8000))
RETURNS BIT
AS
BEGIN
     DECLARE @result INT
     EXEC master.dbo.xp_fileexist @path, @result OUTPUT
     RETURN cast(@result as bit)
END;
GO
