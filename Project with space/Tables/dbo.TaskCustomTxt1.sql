SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskCustomTxt1] (
		[TA_Key]         [int] NOT NULL,
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
		CONSTRAINT [PK__TaskCust__CBEBD6011837881B]
		PRIMARY KEY
		CLUSTERED
		([TA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TaskCustomTxt1]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskCusto__TA_Ke__6A5BAED2]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[TaskCustomTxt1]
	CHECK CONSTRAINT [FK__TaskCusto__TA_Ke__6A5BAED2]

GO
ALTER TABLE [dbo].[TaskCustomTxt1] SET (LOCK_ESCALATION = TABLE)
GO
