SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vDependenciasObjetos] as
SELECT	DISTINCT
		 ParentObjectName = s.name + '.' + OBJECT_NAME(referencing_id)
		,ParentObjectType = o.type_desc
		,ObjectName = 
			COALESCE(referenced_server_name + '.','') + 
			COALESCE(referenced_database_name + '.','') + 
			COALESCE(referenced_schema_name + '.','') + 
			referenced_entity_name
		,ObjectType = o2.type_desc
FROM	sys.sql_expression_dependencies AS sed
		INNER JOIN sys.objects AS o 
			ON	sed.referencing_id = o.OBJECT_ID AND 
				o.type_desc != 'CHECK_CONSTRAINT'
		INNER JOIN sys.schemas AS s
			ON	s.schema_id = o.schema_id
		INNER JOIN sys.objects AS o2
			ON	sed.referenced_id = o2.object_id AND
				o2.type_desc != 'CHECK_CONSTRAINT'
GO
