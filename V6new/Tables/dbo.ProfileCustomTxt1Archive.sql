SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileCustomTxt1Archive] (
		[PRF_Key]        [int] NOT NULL,
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
		CONSTRAINT [PK__ProfileC__74B4E2E76B0FDBE9]
		PRIMARY KEY
		CLUSTERED
		([PRF_Key], [CU_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileCustomTxt1Archive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileCu__PRF_K__2B9F624A]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProfileCustomTxt1Archive]
	CHECK CONSTRAINT [FK__ProfileCu__PRF_K__2B9F624A]

GO
ALTER TABLE [dbo].[ProfileCustomTxt1Archive] SET (LOCK_ESCALATION = TABLE)
GO
