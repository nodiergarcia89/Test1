SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[RiskItemDocuments] (
		[RI_Key]     [int] NOT NULL,
		[DH_Key]     [int] NOT NULL,
		CONSTRAINT [PK__RiskItem__94C59E661F198FD4]
		PRIMARY KEY
		CLUSTERED
		([RI_Key], [DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskItemDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItemD__DH_Ke__4159993F]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[RiskItemDocuments]
	CHECK CONSTRAINT [FK__RiskItemD__DH_Ke__4159993F]

GO
ALTER TABLE [dbo].[RiskItemDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItemD__RI_Ke__424DBD78]
	FOREIGN KEY ([RI_Key]) REFERENCES [dbo].[RiskItem] ([RI_Key])
ALTER TABLE [dbo].[RiskItemDocuments]
	CHECK CONSTRAINT [FK__RiskItemD__RI_Ke__424DBD78]

GO
ALTER TABLE [dbo].[RiskItemDocuments] SET (LOCK_ESCALATION = TABLE)
GO
