SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notifications] (
		[NTF_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[RE_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NTF_Date]             [float] NOT NULL,
		[NTF_Source]           [smallint] NOT NULL,
		[ND_Key]               [int] NOT NULL,
		[NTF_Type]             [smallint] NOT NULL,
		[NTF_Status]           [smallint] NOT NULL,
		[NTF_Subject]          [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NTF_Text]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NTF_ContextKey]       [int] NULL,
		[NTF_ContextCode]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NTF_ContextDate]      [float] NULL,
		[US_CodeLastEdit]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NTF_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Notifica__42DB74D821A0F6C4]
		PRIMARY KEY
		CLUSTERED
		([NTF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Notifications]
	WITH CHECK
	ADD CONSTRAINT [FK__Notificat__ND_Ke__094A4A46]
	FOREIGN KEY ([ND_Key]) REFERENCES [dbo].[NotificationDefinition] ([ND_Key])
ALTER TABLE [dbo].[Notifications]
	CHECK CONSTRAINT [FK__Notificat__ND_Ke__094A4A46]

GO
ALTER TABLE [dbo].[Notifications]
	WITH CHECK
	ADD CONSTRAINT [FK__Notificat__RE_Co__0A3E6E7F]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Notifications]
	CHECK CONSTRAINT [FK__Notificat__RE_Co__0A3E6E7F]

GO
ALTER TABLE [dbo].[Notifications] SET (LOCK_ESCALATION = TABLE)
GO
