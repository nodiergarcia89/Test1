SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentRelations] (
		[DE_CodeMaster]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_CodeSub]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Departme__BAF748C9740F363E]
		PRIMARY KEY
		CLUSTERED
		([DE_CodeMaster], [DE_CodeSub])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentRelations]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DE_Co__5105F123]
	FOREIGN KEY ([DE_CodeMaster]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[DepartmentRelations]
	CHECK CONSTRAINT [FK__Departmen__DE_Co__5105F123]

GO
ALTER TABLE [dbo].[DepartmentRelations]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DE_Co__51FA155C]
	FOREIGN KEY ([DE_CodeSub]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[DepartmentRelations]
	CHECK CONSTRAINT [FK__Departmen__DE_Co__51FA155C]

GO
ALTER TABLE [dbo].[DepartmentRelations] SET (LOCK_ESCALATION = TABLE)
GO
