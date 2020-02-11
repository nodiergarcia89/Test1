SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TaskDocuments] (
		[TA_Key]     [int] NOT NULL,
		[DH_Key]     [int] NOT NULL,
		CONSTRAINT [PK__TaskDocu__E7276D9A1FD8A9E3]
		PRIMARY KEY
		CLUSTERED
		([TA_Key], [DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TaskDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskDocum__DH_Ke__6D381B7D]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[TaskDocuments]
	CHECK CONSTRAINT [FK__TaskDocum__DH_Ke__6D381B7D]

GO
ALTER TABLE [dbo].[TaskDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskDocum__TA_Ke__6E2C3FB6]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[TaskDocuments]
	CHECK CONSTRAINT [FK__TaskDocum__TA_Ke__6E2C3FB6]

GO
ALTER TABLE [dbo].[TaskDocuments] SET (LOCK_ESCALATION = TABLE)
GO
