SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [aux].[SetBitInString] 
    (
    @Source char(10), 
    @Position int,
    @Action char(1) = 'S',
    @Value bit = NULL
    )
RETURNS Char(10)
AS
BEGIN
    DECLARE @work Char(10) = '0000000000'
    SET @work = Right(@work + ISNULL(LTRIM(RTRIM(@Source)), ''), 10)
    SET @Work = 
        CASE @Action
            WHEN 'S'-- Set
                THEN Stuff(@Work, @Position, 1, '1')
            WHEN 'R' -- Reset
                THEN Stuff(@Work, @Position, 1, '0')
            WHEN 'X' -- XOR value with position
                THEN STUFF(@Work, @Position, 1, CAST(CAST(SubString(@Work, @Position, 1) as int) ^ ISNULL(@Value, 0) as CHAR(1)))
            WHEN 'Q'
                THEN '1'
            ---- add other options as needed - this is a quick example.
            ELSE @Action
        END
    RETURN @Work
END
GO
