SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileExpenditureLine] (
		[PEL_Key]         [int] IDENTITY(1, 1) NOT NULL,
		[PRF_Key]         [int] NOT NULL,
		[PEL_Ordinal]     [int] NULL,
		[PEL_Desc]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProfileE__4D34F2BC01F34141]
		PRIMARY KEY
		CLUSTERED
		([PEL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__CC_Co__38F95D68]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[ProfileExpenditureLine]
	CHECK CONSTRAINT [FK__ProfileEx__CC_Co__38F95D68]

GO
ALTER TABLE [dbo].[ProfileExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__CU_Co__39ED81A1]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[ProfileExpenditureLine]
	CHECK CONSTRAINT [FK__ProfileEx__CU_Co__39ED81A1]

GO
ALTER TABLE [dbo].[ProfileExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__PRF_K__3AE1A5DA]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProfileExpenditureLine]
	CHECK CONSTRAINT [FK__ProfileEx__PRF_K__3AE1A5DA]

GO
ALTER TABLE [dbo].[ProfileExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__TY_Co__3BD5CA13]
	FOREIGN KEY ([TY_Code]) REFERENCES [dbo].[Type] ([TY_Code])
ALTER TABLE [dbo].[ProfileExpenditureLine]
	CHECK CONSTRAINT [FK__ProfileEx__TY_Co__3BD5CA13]

GO
CREATE NONCLUSTERED INDEX [PEL_ProfileCCTypeIndex]
	ON [dbo].[ProfileExpenditureLine] ([PRF_Key], [CC_Code], [TY_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProfileExpenditureLine] SET (LOCK_ESCALATION = TABLE)
GO
