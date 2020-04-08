SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DeliverableDocuments] (
		[DV_Key]     [int] NOT NULL,
		[DH_Key]     [int] NOT NULL,
		CONSTRAINT [PK__Delivera__D9E504B146486B8E]
		PRIMARY KEY
		CLUSTERED
		([DV_Key], [DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DH_Ke__383A4359]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[DeliverableDocuments]
	CHECK CONSTRAINT [FK__Deliverab__DH_Ke__383A4359]

GO
ALTER TABLE [dbo].[DeliverableDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DV_Ke__392E6792]
	FOREIGN KEY ([DV_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[DeliverableDocuments]
	CHECK CONSTRAINT [FK__Deliverab__DV_Ke__392E6792]

GO
ALTER TABLE [dbo].[DeliverableDocuments] SET (LOCK_ESCALATION = TABLE)
GO
