SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortfolioScenario] (
		[PSC_Key]            [int] IDENTITY(1, 1) NOT NULL,
		[PFL_Key]            [int] NOT NULL,
		[PSC_Name]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PSC_Version]        [int] NOT NULL,
		[PSC_LastEditOn]     [float] NOT NULL,
		[PSC_Approved]       [smallint] NOT NULL,
		[PSC_ApprovedOn]     [float] NULL,
		[PSC_ApprovedBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Portfoli__F22982A6152838AE]
		PRIMARY KEY
		CLUSTERED
		([PSC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PortfolioScenario]
	ADD
	CONSTRAINT [DF__Portfolio__PSC_A__585CFA28]
	DEFAULT ((0)) FOR [PSC_Approved]
GO
ALTER TABLE [dbo].[PortfolioScenario]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PFL_K__5674B1B6]
	FOREIGN KEY ([PFL_Key]) REFERENCES [dbo].[Portfolio] ([PFL_Key])
ALTER TABLE [dbo].[PortfolioScenario]
	CHECK CONSTRAINT [FK__Portfolio__PFL_K__5674B1B6]

GO
ALTER TABLE [dbo].[PortfolioScenario]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__US_Co__5768D5EF]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[PortfolioScenario]
	CHECK CONSTRAINT [FK__Portfolio__US_Co__5768D5EF]

GO
CREATE UNIQUE NONCLUSTERED INDEX [PFS_PortfolioKeyVersion]
	ON [dbo].[PortfolioScenario] ([PFL_Key], [PSC_Version])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortfolioScenario] SET (LOCK_ESCALATION = TABLE)
GO
