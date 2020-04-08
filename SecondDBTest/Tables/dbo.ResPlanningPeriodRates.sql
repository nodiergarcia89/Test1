SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResPlanningPeriodRates] (
		[RE_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PP_StartDate]       [float] NOT NULL,
		[RPP_CostRate]       [float] NOT NULL,
		[RPP_ChargeRate]     [float] NULL,
		CONSTRAINT [PK__ResPlann__00B336185C57A83E]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResPlanningPeriodRates]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPlanni__PP_St__22D5121F]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ResPlanningPeriodRates]
	CHECK CONSTRAINT [FK__ResPlanni__PP_St__22D5121F]

GO
ALTER TABLE [dbo].[ResPlanningPeriodRates]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPlanni__RE_Co__23C93658]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResPlanningPeriodRates]
	CHECK CONSTRAINT [FK__ResPlanni__RE_Co__23C93658]

GO
ALTER TABLE [dbo].[ResPlanningPeriodRates] SET (LOCK_ESCALATION = TABLE)
GO
