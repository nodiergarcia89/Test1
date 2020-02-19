SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ActionDocuments] (
		[AN_Key]     [int] NOT NULL,
		[DH_Key]     [int] NOT NULL,
		CONSTRAINT [PK__ActionDo__D3BFF381239E4DCF]
		PRIMARY KEY
		CLUSTERED
		([AN_Key], [DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionDoc__AN_Ke__1FA39FB9]
	FOREIGN KEY ([AN_Key]) REFERENCES [dbo].[Action] ([AN_Key])
ALTER TABLE [dbo].[ActionDocuments]
	CHECK CONSTRAINT [FK__ActionDoc__AN_Ke__1FA39FB9]

GO
ALTER TABLE [dbo].[ActionDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionDoc__DH_Ke__2097C3F2]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[ActionDocuments]
	CHECK CONSTRAINT [FK__ActionDoc__DH_Ke__2097C3F2]

GO
ALTER TABLE [dbo].[ActionDocuments] SET (LOCK_ESCALATION = TABLE)
GO
