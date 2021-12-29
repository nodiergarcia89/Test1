SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--USAGE:

--select Address1 
--from PropertyFile_English
--where udf_ContainsNonASCIIChars(Address1, 1) = 1
create function [dbo].[udf_ContainsNonASCIIChars]
(
@string nvarchar(4000),
@checkExtendedCharset bit
)
returns bit
as
begin

    declare @pos int = 0;
    declare @char varchar(1);
    declare @return bit = 0;

    while @pos < len(@string)
    begin
        select @char = substring(@string, @pos, 1)
        if ascii(@char) < 32 or ascii(@char) > 126 
            begin
                if @checkExtendedCharset = 1
                    begin
                        if ascii(@char) not in (9,124,130,138,142,146,150,154,158,160,170,176,180,181,183,184,185,186,192,193,194,195,196,197,199,200,201,202,203,204,205,206,207,209,210,211,212,213,214,216,217,218,219,220,221,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,248,249,250,251,252,253,254,255)
                            begin
                                select @return = 1;
                                select @pos = (len(@string) + 1)
                            end
                        else
                            begin
                                select @pos = @pos + 1
                            end
                    end
                else
                    begin
                        select @return = 1;
                        select @pos = (len(@string) + 1)    
                    end
            end
        else
            begin
                select @pos = @pos + 1
            end
    end

    return @return;

end
GO
