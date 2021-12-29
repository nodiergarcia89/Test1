SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- Uso:
--dbo.RepetitiveReplace
--(
--    'Prueba_9',
--    '%_[0-9]%',
--    '',
--    2
--)

CREATE FUNCTION [dbo].[RepetitiveReplace]
(
    @P_String VARCHAR(MAX),
    @P_Pattern VARCHAR(MAX),
    @P_ReplaceString VARCHAR(MAX),
    @P_ReplaceLength INT = 1
)
RETURNS VARCHAR(MAX)
BEGIN
    DECLARE @Index INT;

    -- Get starting point of pattern
    SET @Index = PATINDEX(@P_Pattern, @P_String);

    while @Index > 0
    begin
        --replace matching charactger at index
        SET @P_String = STUFF(@P_String, PATINDEX(@P_Pattern, @P_String), @P_ReplaceLength, @P_ReplaceString);
        SET @Index = PATINDEX(@P_Pattern, @P_String);
    end

    RETURN @P_String;
END;
GO
