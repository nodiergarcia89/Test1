SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProfileCustomNum1Archive] (
		[PRF_Key]        [int] NOT NULL,
		[CU_Date]        [float] NOT NULL,
		[CU_Value1]      [float] NULL,
		[CU_Value2]      [float] NULL,
		[CU_Value3]      [float] NULL,
		[CU_Value4]      [float] NULL,
		[CU_Value5]      [float] NULL,
		[CU_Value6]      [float] NULL,
		[CU_Value7]      [float] NULL,
		[CU_Value8]      [float] NULL,
		[CU_Value9]      [float] NULL,
		[CU_Value10]     [float] NULL,
		[CU_Value11]     [float] NULL,
		[CU_Value12]     [float] NULL,
		[CU_Value13]     [float] NULL,
		[CU_Value14]     [float] NULL,
		[CU_Value15]     [float] NULL,
		[CU_Value16]     [float] NULL,
		[CU_Value17]     [float] NULL,
		[CU_Value18]     [float] NULL,
		[CU_Value19]     [float] NULL,
		[CU_Value20]     [float] NULL,
		[CU_Value21]     [float] NULL,
		[CU_Value22]     [float] NULL,
		[CU_Value23]     [float] NULL,
		[CU_Value24]     [float] NULL,
		[CU_Value25]     [float] NULL,
		[CU_Value26]     [float] NULL,
		[CU_Value27]     [float] NULL,
		[CU_Value28]     [float] NULL,
		[CU_Value29]     [float] NULL,
		[CU_Value30]     [float] NULL,
		[CU_Value31]     [float] NULL,
		[CU_Value32]     [float] NULL,
		[CU_Value33]     [float] NULL,
		[CU_Value34]     [float] NULL,
		[CU_Value35]     [float] NULL,
		[CU_Value36]     [float] NULL,
		[CU_Value37]     [float] NULL,
		[CU_Value38]     [float] NULL,
		[CU_Value39]     [float] NULL,
		[CU_Value40]     [float] NULL,
		[CU_Value41]     [float] NULL,
		[CU_Value42]     [float] NULL,
		[CU_Value43]     [float] NULL,
		[CU_Value44]     [float] NULL,
		[CU_Value45]     [float] NULL,
		[CU_Value46]     [float] NULL,
		[CU_Value47]     [float] NULL,
		[CU_Value48]     [float] NULL,
		[CU_Value49]     [float] NULL,
		[CU_Value50]     [float] NULL,
		CONSTRAINT [PK__ProfileC__74B4E2E75BCD9859]
		PRIMARY KEY
		CLUSTERED
		([PRF_Key], [CU_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileCustomNum1Archive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileCu__PRF_K__27CED166]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProfileCustomNum1Archive]
	CHECK CONSTRAINT [FK__ProfileCu__PRF_K__27CED166]

GO
ALTER TABLE [dbo].[ProfileCustomNum1Archive] SET (LOCK_ESCALATION = TABLE)
GO
