SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 18/07/2011
-- Description:	Obtener indices de una BD
-- =============================================
CREATE PROCEDURE [dbo].[uspGetAllIndexes] 
AS
BEGIN
	SELECT OBJECT_NAME(t1.object_id) as TableName
			, t1.name as IndexName,
	  (CASE is_primary_key WHEN 1 THEN 'PK' ELSE '' END) as PK,
	  (CASE is_unique WHEN 1 THEN '1' ELSE '0' END)+' '+
	  (CASE t1.type WHEN 1 THEN 'C' WHEN 3 THEN 'X' ELSE 'N' END)+' '+  -- N=Non-clustered, C=Clustered, X=XML
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,1,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,2,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,3,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,4,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,5,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,6,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,7,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,8,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,9,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  (CASE INDEXKEY_PROPERTY(t1.object_id,index_id,10,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
	  '' as 'Tipo',
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,1) as Key1,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,2) as Key2,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,3) as Key3,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,4) as Key4,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,5) as Key5,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,6) as Key6,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,7) as Key7,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,8) as Key8,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,9) as Key9,
	  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(t1.object_id),index_id,10) as Key10
	FROM sys.indexes as t1
	LEFT JOIN sys.objects as t2 on t2.object_id=t1.object_id
	WHERE index_id>0 -- omit the default heap
	  and OBJECTPROPERTY(t1.object_id,'IsMsShipped')=0 -- omit system tables
	  and not (schema_name(schema_id)='dbo' and OBJECT_NAME(t1.object_id)='sysdiagrams') -- omit sysdiagrams
	ORDER BY TableName,PK desc, IndexName
END


GO
