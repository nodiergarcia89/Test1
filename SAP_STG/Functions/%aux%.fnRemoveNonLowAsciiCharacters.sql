SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [aux].[fnRemoveNonLowAsciiCharacters] (@OldString as nVarChar(2000))
RETURNS varChar(2000) AS  
BEGIN 
DECLARE @Count integer, @NewString varChar(2000)
SET @Count =1
SET @NewString = ''
WHILE @Count <= Len(@OldString)
BEGIN
    --If the character is not a regular ascii character it will be removed
    IF  UNICODE(SUBSTRING(@OldString,@Count,1)) < 127
        BEGIN
            SET @NewString  = @NewString + SUBSTRING(@OldString,@Count,1)
        END
    SET @Count = @Count + 1
END
RETURN @NewString
END
GO
