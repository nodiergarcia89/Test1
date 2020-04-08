SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResNotificationDefs] (
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ND_Key]      [int] NOT NULL,
		CONSTRAINT [PK__ResNotif__3D925A545887175A]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [ND_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResNotificationDefs]
	WITH CHECK
	ADD CONSTRAINT [FK__ResNotifi__ND_Ke__20ECC9AD]
	FOREIGN KEY ([ND_Key]) REFERENCES [dbo].[NotificationDefinition] ([ND_Key])
ALTER TABLE [dbo].[ResNotificationDefs]
	CHECK CONSTRAINT [FK__ResNotifi__ND_Ke__20ECC9AD]

GO
ALTER TABLE [dbo].[ResNotificationDefs]
	WITH CHECK
	ADD CONSTRAINT [FK__ResNotifi__RE_Co__21E0EDE6]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResNotificationDefs]
	CHECK CONSTRAINT [FK__ResNotifi__RE_Co__21E0EDE6]

GO
ALTER TABLE [dbo].[ResNotificationDefs] SET (LOCK_ESCALATION = TABLE)
GO
