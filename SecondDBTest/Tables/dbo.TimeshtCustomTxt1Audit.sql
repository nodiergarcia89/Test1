SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeshtCustomTxt1Audit] (
		[TSS_Key]        [int] NOT NULL,
		[TS_Key]         [int] NOT NULL,
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
		CONSTRAINT [PK__TimeshtC__6BA1B8814D9F7493]
		PRIMARY KEY
		CLUSTERED
		([TSS_Key], [TS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TimeshtCustomTxt1Audit]
	WITH CHECK
	ADD CONSTRAINT [FK__TimeshtCustomTxt__09D45A2B]
	FOREIGN KEY ([TSS_Key], [TS_Key]) REFERENCES [dbo].[TimeshtAudit] ([TSS_Key], [TS_Key])
ALTER TABLE [dbo].[TimeshtCustomTxt1Audit]
	CHECK CONSTRAINT [FK__TimeshtCustomTxt__09D45A2B]

GO
ALTER TABLE [dbo].[TimeshtCustomTxt1Audit] SET (LOCK_ESCALATION = TABLE)
GO
