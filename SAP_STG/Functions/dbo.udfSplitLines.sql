SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfSplitLines]
(
    @pString    VARCHAR(7999),
    @pLineLen   INT,
    @pDelim     CHAR(1)
)
RETURNS TABLE
   WITH SCHEMABINDING
AS  
RETURN
WITH
      E1(N) AS ( --=== Create Ten 1's
                 SELECT 1 UNION ALL SELECT 1 UNION ALL
                 SELECT 1 UNION ALL SELECT 1 UNION ALL
                 SELECT 1 UNION ALL SELECT 1 UNION ALL
                 SELECT 1 UNION ALL SELECT 1 UNION ALL
                 SELECT 1 UNION ALL SELECT 1 --10
               ),
      E2(N) AS (SELECT 1 FROM E1 a, E1 b),   --100
      E4(N) AS (SELECT 1 FROM E2 a, E2 b),   --10,000
cteTally(N) AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT N)) FROM E4),
lines AS (
  SELECT TOP 1
         1 as LineNumber,
         ltrim(rtrim(SUBSTRING(@pString, 1, N))) as Line,
         N + 1 as start
  FROM cteTally
  WHERE N <= DATALENGTH(@pString) + 1
    AND N <= @pLineLen + 1
    AND SUBSTRING(@pString + @pDelim, N, 1) = @pDelim
  ORDER BY N DESC
UNION ALL
  SELECT LineNumber, Line, start
  FROM (
    SELECT LineNumber + 1 as LineNumber,
           ltrim(rtrim(SUBSTRING(@pString, start, N))) as Line,
           start + N + 1 as start,
           ROW_NUMBER() OVER (ORDER BY N DESC) as r
    FROM cteTally, lines
    WHERE N <= DATALENGTH(@pString) + 1 - start
      AND N <= @pLineLen
      AND SUBSTRING(@pString + @pDelim, start + N, 1) = @pDelim
  ) A
  WHERE r = 1
)
SELECT LineNumber, Line
FROM lines
GO
