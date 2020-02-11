SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileBenefitLine] (
		[PBL_Key]            [int] IDENTITY(1, 1) NOT NULL,
		[PRF_Key]            [int] NOT NULL,
		[PBL_Ordinal]        [int] NULL,
		[PBL_TargetDate]     [float] NULL,
		[DV_Key]             [int] NULL,
		[BE_Key]             [int] NOT NULL,
		[CU_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProfileB__D4D246F1505BE5AD]
		PRIMARY KEY
		CLUSTERED
		([PBL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileBenefitLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileBe__BE_Ke__2215F810]
	FOREIGN KEY ([BE_Key]) REFERENCES [dbo].[Benefit] ([BE_Key])
ALTER TABLE [dbo].[ProfileBenefitLine]
	CHECK CONSTRAINT [FK__ProfileBe__BE_Ke__2215F810]

GO
ALTER TABLE [dbo].[ProfileBenefitLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileBe__CU_Co__230A1C49]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[ProfileBenefitLine]
	CHECK CONSTRAINT [FK__ProfileBe__CU_Co__230A1C49]

GO
ALTER TABLE [dbo].[ProfileBenefitLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileBe__DV_Ke__23FE4082]
	FOREIGN KEY ([DV_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[ProfileBenefitLine]
	CHECK CONSTRAINT [FK__ProfileBe__DV_Ke__23FE4082]

GO
ALTER TABLE [dbo].[ProfileBenefitLine] SET (LOCK_ESCALATION = TABLE)
GO
