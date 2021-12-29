SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_HTMLDecode](
       @vcWhat NVARCHAR(MAX)
       ,@toDecodeMainISOSymbols bit = 1
       ,@toDecodeISOChars bit = 1
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
       DECLARE @vcResult NVARCHAR(MAX);
       DECLARE @siPos INT ,@vcEncoded NVARCHAR(9) ,@siChar INT;
       --SET @vcResult = RTRIM(LTRIM(CAST(REPLACE(@vcWhat COLLATE Latin1_General_BIN, CHAR(0), '') AS NVARCHAR(MAX))));
       SET @vcResult = RTRIM(LTRIM(CAST(REPLACE(@vcWhat COLLATE  Latin1_General_CI_AS, CHAR(0), '') AS NVARCHAR(MAX))));
       SELECT @vcResult = REPLACE(REPLACE(@vcResult, '&#160;', ' '), '&nbsp;', ' ');
       IF @vcResult = '' RETURN @vcResult;

       declare @s varchar(35);
       declare @n int; set @n = 6;
       declare @i int;

       while @n > 2
       begin
           set @s = '';
           set @i=1;
           while @i<=@n
           begin
               set @s = @s + '[0-9]';
               set @i = @i + 1;
           end
           set @s = '%&#' + @s + '%';
           SELECT @siPos = PATINDEX(@s, @vcResult);
           WHILE @siPos > 0
           BEGIN
               SELECT @vcEncoded = SUBSTRING(@vcResult, @siPos, @n+3)
                   ,@siChar = CAST(SUBSTRING(@vcEncoded, 3, @n) AS INT)
                   ,@vcResult = REPLACE(@vcResult, @vcEncoded, NCHAR(@siChar))
                   ,@siPos = PATINDEX(@s, @vcResult);
           END
           set @n = @n - 1;
       end

       if @toDecodeMainISOSymbols=1
       begin
           select @vcResult = REPLACE(REPLACE(@vcResult, NCHAR(160), ' '), CHAR(160), ' ');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult, '&amp;', '&'), '&quot;', '"'), '&lt;', '<'), '&gt;', '>'), '&amp;amp;', '&'),'&rdquo;','”'),'&bdquo;','„'),'&ndash;','–'),'&mdash;','—');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult,'&lsquo;','‘'),'&rsquo;','’'),'&bull;','•'),'&hellip;','…'),'&permil;','‰') COLLATE Latin1_General_CI_AS,'&prime;','′') COLLATE Latin1_General_CI_AS,'&Prime;','″'),'&circ;','ˆ'),'&tilde;','˜'),'&nbsp;',' ');
       end

       if @toDecodeISOChars=1
       begin
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(@vcResult COLLATE Latin1_General_CI_AS,'&Scaron;','Š') COLLATE Latin1_General_CI_AS,'&scaron;','š') COLLATE Latin1_General_CI_AS,'&Ccedil;','Ç') COLLATE Latin1_General_CI_AS,'&ccedil;','ç');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult,'&Agrave;','À') COLLATE Latin1_General_CI_AS,'&agrave;','à') COLLATE Latin1_General_CI_AS,'&Aacute;','Á') COLLATE Latin1_General_CI_AS,'&aacute;','á') COLLATE Latin1_General_CI_AS,'&Acirc;','Â') COLLATE Latin1_General_CI_AS,'&acirc;','â') COLLATE Latin1_General_CI_AS,'&Atilde;','Ã') COLLATE Latin1_General_CI_AS,'&atilde;','ã') COLLATE Latin1_General_CI_AS,'&Auml;','Ä') COLLATE Latin1_General_CI_AS,'&auml;','ä') COLLATE Latin1_General_CI_AS,'&Aring;','Å') COLLATE Latin1_General_CI_AS,'&aring;','å') COLLATE Latin1_General_CI_AS,'&AElig;','Æ') COLLATE Latin1_General_CI_AS,'&aelig;','æ');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult COLLATE Latin1_General_CI_AS,'&Egrave','È') COLLATE Latin1_General_CI_AS,'&egrave','è') COLLATE Latin1_General_CI_AS,'&Eacute;','É') COLLATE Latin1_General_CI_AS,'&eacute;','é') COLLATE Latin1_General_CI_AS,'&Ecirc;','Ê') COLLATE Latin1_General_CI_AS,'&ecirc;','ê') COLLATE Latin1_General_CI_AS,'&Euml;','Ë') COLLATE Latin1_General_CI_AS,'&euml;','ë');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult COLLATE Latin1_General_CI_AS,'&Igrave;','Ì') COLLATE Latin1_General_CI_AS,'&igrave;','ì') COLLATE Latin1_General_CI_AS,'&Iacute;','Í') COLLATE Latin1_General_CI_AS,'&iacute;','í') COLLATE Latin1_General_CI_AS,'&Icirc;','Î') COLLATE Latin1_General_CI_AS,'&icirc;','î') COLLATE Latin1_General_CI_AS,'&Iuml;','Ï') COLLATE Latin1_General_CI_AS,'&iuml;','ï');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult COLLATE Latin1_General_CI_AS,'&Ograve;','Ò') COLLATE Latin1_General_CI_AS,'&ograve;','ò') COLLATE Latin1_General_CI_AS,'&Oacute;','Ó') COLLATE Latin1_General_CI_AS,'&oacute;','ó') COLLATE Latin1_General_CI_AS,'&Ocirc;','Ô') COLLATE Latin1_General_CI_AS,'&ocirc;','ô') COLLATE Latin1_General_CI_AS,'&Otilde;','Õ') COLLATE Latin1_General_CI_AS,'&otilde;','õ') COLLATE Latin1_General_CI_AS,'&Ouml;','Ö') COLLATE Latin1_General_CI_AS,'&ouml;','ö') COLLATE Latin1_General_CI_AS,'&Oslash','Ø') COLLATE Latin1_General_BIN,'&oslash','ø');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult COLLATE Latin1_General_CI_AS,'&Ugrave;','Ù') COLLATE Latin1_General_CI_AS,'&ugrave;','ù') COLLATE Latin1_General_CI_AS,'&Uacute;','Ú') COLLATE Latin1_General_CI_AS,'&uacute;','ú') COLLATE Latin1_General_CI_AS,'&Ucirc;','Û') COLLATE Latin1_General_CI_AS,'&ucirc;','û') COLLATE Latin1_General_CI_AS,'&Uuml;','Ü') COLLATE Latin1_General_CI_AS,'&uuml;','ü');
           select @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult COLLATE Latin1_General_CI_AS,'&ETH;','Ð') COLLATE Latin1_General_CI_AS,'&eth;','ð') COLLATE Latin1_General_CI_AS,'&Ntilde;','Ñ') COLLATE Latin1_General_CI_AS,'&ntilde;','ñ') COLLATE Latin1_General_CI_AS,'&Yacute;','Ý') COLLATE Latin1_General_CI_AS,'&yacute;','ý') COLLATE Latin1_General_CI_AS,'&THORN;','Þ') COLLATE Latin1_General_CI_AS,'&thorn;','þ') COLLATE Latin1_General_CI_AS,'&szlig;','ß');
       end
       RETURN @vcResult;
END
-- test:
-- select dbo.fn_HTMLDecode(N'A fine example of man and nature co-existing is Slovenia&#8217;s ecological tourist farms.',1,1)
-- select dbo.fn_HTMLDecode(N'm0 &#50752;&#51064;&#48516;&#50556;&#50640;&#49436; m1 &#44032;&#51109; m2 &#50689;&#54693;&#47141; m3&#51080;&#45716;m10',1,1)
GO
