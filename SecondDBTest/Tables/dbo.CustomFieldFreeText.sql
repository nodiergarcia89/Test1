SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomFieldFreeText] (
		[CFF_Id]                [int] IDENTITY(1, 1) NOT NULL,
		[CF_Key]                [int] NOT NULL,
		[CFF_RecordCode]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFF_RecordKey]         [int] NULL,
		[CFF_PlainText]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFF_FormattedText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__CustomFi__A2AE8E1F7BE56230]
		PRIMARY KEY
		CLUSTERED
		([CFF_Id])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomFieldFreeText]
	WITH CHECK
	ADD CONSTRAINT [FK__CustomFie__CF_Ke__233F2673]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[CustomFieldFreeText]
	CHECK CONSTRAINT [FK__CustomFie__CF_Ke__233F2673]

GO
CREATE NONCLUSTERED INDEX [CFF_RecordCodeIndex]
	ON [dbo].[CustomFieldFreeText] ([CF_Key], [CFF_RecordCode])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CFF_RecordKeyIndex]
	ON [dbo].[CustomFieldFreeText] ([CF_Key], [CFF_RecordKey])
	ON [PRIMARY]
GO
CREATE FULLTEXT INDEX ON [dbo].[CustomFieldFreeText]
	([CFF_PlainText] LANGUAGE 1033)
	KEY INDEX [PK__CustomFi__A2AE8E1F7BE56230]
	ON (FILEGROUP [PRIMARY], [CAT_CustomField])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[CustomFieldFreeText] SET (LOCK_ESCALATION = TABLE)
GO
