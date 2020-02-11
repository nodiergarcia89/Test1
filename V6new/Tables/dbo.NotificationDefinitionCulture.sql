SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NotificationDefinitionCulture] (
		[ND_Key]          [int] NOT NULL,
		[CLC_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NDC_Desc]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NDC_Subject]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NDC_Text]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Notifica__64B31AD81DD065E0]
		PRIMARY KEY
		CLUSTERED
		([ND_Key], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[NotificationDefinitionCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__Notificat__ND_Ke__0856260D]
	FOREIGN KEY ([ND_Key]) REFERENCES [dbo].[NotificationDefinition] ([ND_Key])
ALTER TABLE [dbo].[NotificationDefinitionCulture]
	CHECK CONSTRAINT [FK__Notificat__ND_Ke__0856260D]

GO
ALTER TABLE [dbo].[NotificationDefinitionCulture] SET (LOCK_ESCALATION = TABLE)
GO
