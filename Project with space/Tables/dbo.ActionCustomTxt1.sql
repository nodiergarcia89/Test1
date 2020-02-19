SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionCustomTxt1] (
		[AN_Key]         [int] NOT NULL,
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
		CONSTRAINT [PK__ActionCu__FF73481A1FCDBCEB]
		PRIMARY KEY
		CLUSTERED
		([AN_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionCustomTxt1]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionCus__AN_Ke__1EAF7B80]
	FOREIGN KEY ([AN_Key]) REFERENCES [dbo].[Action] ([AN_Key])
ALTER TABLE [dbo].[ActionCustomTxt1]
	CHECK CONSTRAINT [FK__ActionCus__AN_Ke__1EAF7B80]

GO
ALTER TABLE [dbo].[ActionCustomTxt1] SET (LOCK_ESCALATION = TABLE)
GO
