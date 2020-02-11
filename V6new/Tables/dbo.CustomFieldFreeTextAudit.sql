SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomFieldFreeTextAudit] (
		[CFFAU_AuditId]             [int] NOT NULL,
		[CFF_Id]                    [int] NOT NULL,
		[CF_Key]                    [int] NOT NULL,
		[CFF_RecordCode]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFF_RecordKey]             [int] NULL,
		[CFF_PlainText]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFF_FormattedText]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFFAU_AuditEntityType]     [int] NULL,
		CONSTRAINT [PK__CustomFi__F1EF65417FB5F314]
		PRIMARY KEY
		CLUSTERED
		([CFFAU_AuditId], [CFF_Id])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomFieldFreeTextAudit] SET (LOCK_ESCALATION = TABLE)
GO
