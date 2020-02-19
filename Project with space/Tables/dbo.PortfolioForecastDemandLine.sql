SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortfolioForecastDemandLine] (
		[PFDL_Key]        [int] IDENTITY(1, 1) NOT NULL,
		[PSF_Key]         [int] NULL,
		[DE_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LH_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Portfoli__74DB7361269B4AAD]
		PRIMARY KEY
		CLUSTERED
		([PFDL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PSF_K__61E66462]
	FOREIGN KEY ([PSF_Key]) REFERENCES [dbo].[PortfolioScenarioForecast] ([PSF_Key])
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	CHECK CONSTRAINT [FK__Portfolio__PSF_K__61E66462]

GO
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__DE_Co__62DA889B]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	CHECK CONSTRAINT [FK__Portfolio__DE_Co__62DA889B]

GO
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__RE_Co__63CEACD4]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	CHECK CONSTRAINT [FK__Portfolio__RE_Co__63CEACD4]

GO
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__RE_Co__64C2D10D]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[PortfolioForecastDemandLine]
	CHECK CONSTRAINT [FK__Portfolio__RE_Co__64C2D10D]

GO
CREATE UNIQUE NONCLUSTERED INDEX [PFD_ProfileForecastDepartmentRole]
	ON [dbo].[PortfolioForecastDemandLine] ([PSF_Key], [DE_Code], [RE_CodeRole], [RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortfolioForecastDemandLine] SET (LOCK_ESCALATION = TABLE)
GO
