SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- Description: Turns a query into a formatted HTML table. Useful for emails. 
-- Any ORDER BY clause needs to be passed in the separate ORDER BY parameter.
-- =============================================
CREATE PROC [dbo].[spQueryToHtmlTable2] 
(
  @query nvarchar(MAX), --A query to turn into HTML format. It should not include an ORDER BY clause.
  @orderBy nvarchar(MAX) = NULL, --An optional ORDER BY clause. It should contain the words 'ORDER BY'.
  @html nvarchar(MAX) = NULL OUTPUT --The HTML output of the procedure.
)
AS
BEGIN   
  SET NOCOUNT ON;

  IF @orderBy IS NULL BEGIN
    SET @orderBy = ''  
  END

  declare @TableHead varchar(max)

 
  --HTML layout--
Set @TableHead = 
'<style>' +
'.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
'.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
'.tab tr:nth-child(even) {background-color: #dddddd}' +
'.tab {width:100%}' +
'</style>' +
'<table class="tab" cellpadding=1 cellspacing=0 border=1>' 

  SET @orderBy = REPLACE(@orderBy, '''', '''''');

  DECLARE @realQuery nvarchar(MAX) = '
    DECLARE @headerRow nvarchar(MAX);
    DECLARE @cols nvarchar(MAX);    

    SELECT * INTO #dynSql FROM (' + @query + ') sub;

    SELECT @cols = COALESCE(@cols + '', '''''''', '', '''') + ''['' + name + ''] AS ''''td''''''
    FROM tempdb.sys.columns 
    WHERE object_id = object_id(''tempdb..#dynSql'')
    ORDER BY column_id;


    SET @cols = ''SET @html = CAST(( SELECT '' + @cols + '' FROM #dynSql ' + @orderBy + ' FOR XML PATH(''''tr''''), ELEMENTS XSINIL) AS nvarchar(max))''    


    EXEC sys.sp_executesql @cols, N''@html nvarchar(MAX) OUTPUT'', @html=@html OUTPUT

    SELECT @headerRow = COALESCE(@headerRow + '''', '''') + ''<th>'' + name + ''</th>'' 
    FROM tempdb.sys.columns 
    WHERE object_id = object_id(''tempdb..#dynSql'')
    ORDER BY column_id;

    SET @headerRow = ''<tr>'' + @headerRow + ''</tr>'';


    SET @html =' + '''' +  @TableHead + '''' + '+ @headerRow + @html + ''</table>'''



  EXEC sys.sp_executesql @realQuery, N'@html nvarchar(MAX) OUTPUT', @html=@html OUTPUT

  SET @html=REPLACE(@html,'\n', '<br>') -- Para los saltos de linea



END


GO
