SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ReportSubReports] (
		[RH_Key]        [int] NOT NULL,
		[RH_KeySub]     [int] NOT NULL,
		[RSR_Order]     [int] NULL,
		CONSTRAINT [PK__ReportSu__06DC7374100C566E]
		PRIMARY KEY
		CLUSTERED
		([RH_Key], [RH_KeySub])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportSubReports]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportSub__RH_Ke__7231DAC4]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ReportSubReports]
	CHECK CONSTRAINT [FK__ReportSub__RH_Ke__7231DAC4]

GO
ALTER TABLE [dbo].[ReportSubReports]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportSub__RH_Ke__7325FEFD]
	FOREIGN KEY ([RH_KeySub]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ReportSubReports]
	CHECK CONSTRAINT [FK__ReportSub__RH_Ke__7325FEFD]

GO
ALTER TABLE [dbo].[ReportSubReports] SET (LOCK_ESCALATION = TABLE)
GO
