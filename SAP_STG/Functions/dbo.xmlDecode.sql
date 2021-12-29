SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[xmlDecode] (@string nvarchar(max))
returns varchar(max)
begin
       return cast(@string as XML).value('.[1]','nvarchar(max)' )
end;
GO
