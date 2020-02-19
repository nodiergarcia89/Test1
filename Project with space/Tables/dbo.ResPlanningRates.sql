SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResPlanningRates] (
		[RE_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RPR_StartDate]           [float] NOT NULL,
		[RPR_Rate]                [float] NOT NULL,
		[CU_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RPR_LocalRate]           [float] NULL,
		[RPR_ChargeRate]          [float] NULL,
		[RPR_LocalChargeRate]     [float] NULL,
		CONSTRAINT [PK__ResPlann__C690CE4060283922]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [RPR_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResPlanningRates]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPlanni__CU_Co__24BD5A91]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[ResPlanningRates]
	CHECK CONSTRAINT [FK__ResPlanni__CU_Co__24BD5A91]

GO
ALTER TABLE [dbo].[ResPlanningRates]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPlanni__RE_Co__25B17ECA]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResPlanningRates]
	CHECK CONSTRAINT [FK__ResPlanni__RE_Co__25B17ECA]

GO
ALTER TABLE [dbo].[ResPlanningRates] SET (LOCK_ESCALATION = TABLE)
GO
