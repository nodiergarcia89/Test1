SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileCustomSTxt1Archive] (
		[PRF_Key]        [int] NOT NULL,
		[CU_Date]        [float] NOT NULL,
		[CU_Value1]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value2]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value3]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value4]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value5]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value6]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value7]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value8]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value9]      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value10]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value11]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value12]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value13]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value14]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value15]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value16]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value17]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value18]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value19]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value20]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value21]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value22]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value23]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value24]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value25]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value26]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value27]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value28]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value29]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value30]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value31]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value32]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value33]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value34]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value35]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value36]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value37]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value38]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value39]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value40]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value41]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value42]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value43]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value44]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value45]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value46]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value47]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value48]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value49]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Value50]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProfileC__74B4E2E7636EBA21]
		PRIMARY KEY
		CLUSTERED
		([PRF_Key], [CU_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileCustomSTxt1Archive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileCu__PRF_K__29B719D8]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProfileCustomSTxt1Archive]
	CHECK CONSTRAINT [FK__ProfileCu__PRF_K__29B719D8]

GO
ALTER TABLE [dbo].[ProfileCustomSTxt1Archive] SET (LOCK_ESCALATION = TABLE)
GO
