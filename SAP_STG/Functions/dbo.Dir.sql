SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Dir](@Wildcard VARCHAR(8000))
/* returns a table representing all the items in a folder. It takes as parameter the path to the folder. It does not take wildcards in the same way as a DIR command. Instead, you would be expected to filter the results of the function using SQL commands
Notice that the size of the item (e.g. file) is not returned by this function. 

This function uses the Windows Shell COM object via OLE automation. It opens a folder and iterates though the items listing their relevant properties. You can use the SHELL object to do all manner of things such as printing, copying, and moving filesystem objects, accessing the registry and so on. Powerful medicine.

--e.g.
--list all subdirectories directories beginning with M from "c:\program files"
SELECT [path] FROM dbo.dir('c:\program files') 
       WHERE name LIKE 'm%' AND IsFolder =1
SELECT  * FROM dbo.dir('C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\LOG')

*/
RETURNS @MyDir TABLE 
(
    -- columns returned by the function
       [name] VARCHAR(2000),    --the name of the filesystem object
       [path] VARCHAR(2000),    --Contains the item's full path and name. 
       [ModifyDate] DATETIME,   --the time it was last modified 
	   --[CreatedDate] DATETIME,	
       [IsFileSystem] INT,      --1 if it is part of the file system
       [IsFolder] INT,          --1 if it is a folsdder otherwise 0
       [error] VARCHAR(2000)    --if an error occured, gives the error otherwise null
)
AS
-- body of the function
BEGIN
   DECLARE 
       
	   
	   --all the objects used
       @objShellApplication INT, 
       @objFolder INT,
       @objItem INT,
       @objErrorObject INT,
       @objFolderItems INT, 
       --potential error message shows where error occurred.
       @strErrorMessage VARCHAR(1000), 
       --command sent to OLE automation
       @Command VARCHAR(1000), 
       @hr INT, --OLE result (0 if OK)
       @count INT,@ii INT,
       @name VARCHAR(2000),--the name of the current item
       @path VARCHAR(2000),--the path of the current item 
       @ModifyDate DATETIME,--the date the current item last modified
	   --@CreatedDate DATETIME,
       @IsFileSystem INT, --1 if the current item is part of the file system
       @IsFolder INT --1 if the current item is a file
   IF LEN(COALESCE(@Wildcard,''))<2 
       RETURN

   SELECT  @strErrorMessage = 'opening the Shell Application Object' 
   EXECUTE @hr = sp_OACreate 'Shell.Application', 
       @objShellApplication OUT 
   --now we get the folder.
   IF @HR = 0  
       SELECT  @objErrorObject = @objShellApplication, 
               @strErrorMessage = 'Getting Folder"' + @wildcard + '"', 
               @command = 'NameSpace("'+@wildcard+'")' 
   IF @HR = 0  
       EXECUTE @hr = sp_OAMethod @objShellApplication, @command, 
           @objFolder OUT
   IF @objFolder IS NULL RETURN --nothing there. Sod the error message
   --and then the number of objects in the folder
       SELECT  @objErrorObject = @objFolder, 
               @strErrorMessage = 'Getting count of Folder items in "' + @wildcard + '"', 
               @command = 'Items.Count' 
   IF @HR = 0  
       EXECUTE @hr = sp_OAMethod @objfolder, @command, 
           @count OUT
    IF @HR = 0 --now get the FolderItems collection 
        SELECT  @objErrorObject = @objFolder, 
                @strErrorMessage = ' getting folderitems',
               @command='items()'
    IF @HR = 0  
        EXECUTE @hr = sp_OAMethod @objFolder, 
            @command, @objFolderItems OUTPUT 
   SELECT @ii = 0
   WHILE @hr = 0 AND @ii< @count --iterate through the FolderItems collection
            BEGIN 
                IF @HR = 0  
                    SELECT  @objErrorObject = @objFolderItems, 
                            @strErrorMessage = ' getting folder item ' 
                                   + CAST(@ii AS VARCHAR(5)),
                           @command='item(' + CAST(@ii AS VARCHAR(5))+')'
                           --@Command='GetDetailsOf('+ cast(@ii as varchar(5))+',1)'
                IF @HR = 0  
                    EXECUTE @hr = sp_OAMethod @objFolderItems, 
                        @command, @objItem OUTPUT 

                IF @HR = 0  
                    SELECT  @objErrorObject = @objItem, 
                            @strErrorMessage = ' getting folder item properties'
                                   + CAST(@ii AS VARCHAR(5))
                IF @HR = 0  
                    EXECUTE @hr = sp_OAMethod @objItem, 
                        'path', @path OUTPUT
                IF @HR = 0  
                    EXECUTE @hr = sp_OAMethod @objItem, 
                        'name', @name OUTPUT
                IF @HR = 0  
                    EXECUTE @hr = sp_OAMethod @objItem, 
                        'ModifyDate', @ModifyDate OUTPUT
                --IF @HR = 0  
                --    EXECUTE @hr = sp_OAMethod @objItem, 
                --        'CreateDate', @CreatedDate OUTPUT
                IF @HR = 0  
                    EXECUTE @hr = sp_OAMethod @objItem, 
                        'IsFileSystem', @IsFileSystem OUTPUT
                IF @HR = 0  
                    EXECUTE @hr = sp_OAMethod @objItem, 
                        'IsFolder', @IsFolder OUTPUT
               --and insert the properties into a table
               INSERT INTO @MyDir ([NAME], [path], ModifyDate, IsFileSystem, IsFolder) --CreatedDate, 
                   SELECT @NAME, @path, @ModifyDate, @IsFileSystem, @IsFolder --@CreatedDate, 
               IF @HR = 0  EXECUTE sp_OADestroy @objItem 
               SELECT @ii=@ii+1
            END 
        IF @hr <> 0  
            BEGIN 
                DECLARE @Source VARCHAR(255), 
                    @Description VARCHAR(255), 
                    @Helpfile VARCHAR(255), 
                    @HelpID INT 
     
                EXECUTE sp_OAGetErrorInfo @objErrorObject, @source OUTPUT, 
                    @Description OUTPUT, @Helpfile OUTPUT, @HelpID OUTPUT 
                SELECT  @strErrorMessage = 'Error whilst ' 
                        + COALESCE(@strErrorMessage, 'doing something') + ', ' 
                        + COALESCE(@Description, '') 
                INSERT INTO @MyDir(error) SELECT  LEFT(@strErrorMessage,2000) 
            END 
        EXECUTE sp_OADestroy @objFolder 
        EXECUTE sp_OADestroy @objShellApplication

RETURN
END
GO
