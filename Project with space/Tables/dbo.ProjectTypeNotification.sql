SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProjectTypeNotification] (
		[PT_Key]     [int] NOT NULL,
		[ND_Key]     [int] NOT NULL,
		CONSTRAINT [PK_ProjectTypeNotification]
		PRIMARY KEY
		CLUSTERED
		([PT_Key], [ND_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectTypeNotification]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__PT_Ke__19018F22]
	FOREIGN KEY ([PT_Key]) REFERENCES [dbo].[ProjectType] ([PT_Key])
ALTER TABLE [dbo].[ProjectTypeNotification]
	CHECK CONSTRAINT [FK__ProjectTy__PT_Ke__19018F22]

GO
ALTER TABLE [dbo].[ProjectTypeNotification]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__ND_Ke__19F5B35B]
	FOREIGN KEY ([ND_Key]) REFERENCES [dbo].[NotificationDefinition] ([ND_Key])
ALTER TABLE [dbo].[ProjectTypeNotification]
	CHECK CONSTRAINT [FK__ProjectTy__ND_Ke__19F5B35B]

GO
ALTER TABLE [dbo].[ProjectTypeNotification] SET (LOCK_ESCALATION = TABLE)
GO
