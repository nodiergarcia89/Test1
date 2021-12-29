SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [aux].[Udf_ReplaceChars] (
  @cadena VARCHAR(500),  -- String to manipulate
  @caracteresElim VARCHAR(100),  -- String of characters to be replaced
  @caracteresReem VARCHAR(100)   -- String of characters for replacement
) 
RETURNS VARCHAR(500)
AS
BEGIN
  DECLARE @cadenaFinal VARCHAR(500), @longCad INT, @pos INT, @caracter CHAR(1), @posCarER INT;
  SELECT
    @cadenaFinal = '',
    @longCad = LEN(@cadena),
    @pos = 1;

  IF LEN(@caracteresElim)<>LEN(@caracteresReem)
    BEGIN
      RETURN NULL;
    END

  WHILE @pos <= @longCad
    BEGIN
      SELECT
        @caracter = SUBSTRING(@cadena,@pos,1),
        @pos = @pos + 1,
        @posCarER = CHARINDEX(@caracter,@caracteresElim);

      IF @posCarER <= 0
        BEGIN
          SET @cadenaFinal = @cadenaFinal + @caracter;
        END
      ELSE
        BEGIN
          SET @cadenaFinal = @cadenaFinal + SUBSTRING(@caracteresReem,@posCarER,1)
        END
    END

  RETURN @cadenaFinal;
END
GO
