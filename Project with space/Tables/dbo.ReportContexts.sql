SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ReportContexts] (
		[RH_Key]     [int] NOT NULL,
		[CA_Key]     [int] NOT NULL,
		CONSTRAINT [PK__ReportCo__15C345F07928F116]
		PRIMARY KEY
		CLUSTERED
		([RH_Key], [CA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportContexts]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportCon__RH_Ke__6C79016E]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ReportContexts]
	CHECK CONSTRAINT [FK__ReportCon__RH_Ke__6C79016E]

GO
ALTER TABLE [dbo].[ReportContexts] SET (LOCK_ESCALATION = TABLE)
GO
