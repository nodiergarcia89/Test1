SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectCustomTxt1Archive] (
		[PR_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CU_Date]        [float] NOT NULL,
		[CU_Value1]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value2]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value3]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value4]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value5]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value6]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value7]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value8]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value9]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value10]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value11]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value12]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value13]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value14]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value15]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PSS_Key]        [int] NULL,
		CONSTRAINT [PK__ProjectC__2B27E63024485945]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [CU_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectCustomTxt1Archive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectCu__PR_Co__4376EBDB]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectCustomTxt1Archive]
	CHECK CONSTRAINT [FK__ProjectCu__PR_Co__4376EBDB]

GO
ALTER TABLE [dbo].[ProjectCustomTxt1Archive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectCu__PSS_K__67352964]
	FOREIGN KEY ([PSS_Key]) REFERENCES [dbo].[ProjectSnapshots] ([PSS_Key])
ALTER TABLE [dbo].[ProjectCustomTxt1Archive]
	CHECK CONSTRAINT [FK__ProjectCu__PSS_K__67352964]

GO
ALTER TABLE [dbo].[ProjectCustomTxt1Archive] SET (LOCK_ESCALATION = TABLE)
GO
