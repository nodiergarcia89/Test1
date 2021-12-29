SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[udfSplitString]
(   
    @str varchar(max),
    @length int
)
RETURNS @Results TABLE( Result varchar(50),Sequence INT ) 
AS
BEGIN

DECLARE @Sequence INT 
SET @Sequence = 1

    DECLARE @s varchar(50)
    WHILE len(@str) > 0
    BEGIN
        SET @s = left(@str, @length)
        INSERT @Results VALUES (@s,@Sequence)

        IF(len(@str)<@length)
        BREAK

        SET @str = right(@str, len(@str) - @length)
        SET @Sequence = @Sequence + 1
    END
    RETURN 
END
GO
