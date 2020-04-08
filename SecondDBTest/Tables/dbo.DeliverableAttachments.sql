SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliverableAttachments] (
		[DV_Key]       [int] NOT NULL,
		[DVA_Path]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Delivera__EEFD6A212B947552]
		PRIMARY KEY
		CLUSTERED
		([DV_Key], [DVA_Path])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DV_Ke__2FA4FD58]
	FOREIGN KEY ([DV_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[DeliverableAttachments]
	CHECK CONSTRAINT [FK__Deliverab__DV_Ke__2FA4FD58]

GO
ALTER TABLE [dbo].[DeliverableAttachments] SET (LOCK_ESCALATION = TABLE)
GO
