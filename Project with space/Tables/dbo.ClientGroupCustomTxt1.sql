SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientGroupCustomTxt1] (
		[CG_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
		CONSTRAINT [PK__ClientGr__4B8DB4260A688BB1]
		PRIMARY KEY
		CLUSTERED
		([CG_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientGroupCustomTxt1]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__CG_Co__7D197D8B]
	FOREIGN KEY ([CG_Code]) REFERENCES [dbo].[ClientGroups] ([CG_Code])
ALTER TABLE [dbo].[ClientGroupCustomTxt1]
	CHECK CONSTRAINT [FK__ClientGro__CG_Co__7D197D8B]

GO
ALTER TABLE [dbo].[ClientGroupCustomTxt1] SET (LOCK_ESCALATION = TABLE)
GO
