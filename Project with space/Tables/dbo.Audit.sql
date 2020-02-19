SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Audit] (
		[AU_Key]               [int] IDENTITY(1, 1) NOT NULL,
		[AU_EntityType]        [smallint] NULL,
		[AU_Identifier]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AU_AuditType]         [int] NOT NULL,
		[AU_CustomMessage]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AU_LastEdit]          [float] NOT NULL,
		[AU_FieldName]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AU_FieldAlias]        [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AU_OldValue]          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AU_NewValue]          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Audit__7A6D21757F053D3D]
		PRIMARY KEY
		CLUSTERED
		([AU_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Audit]
	ADD
	CONSTRAINT [DF__Audit__AU_AuditT__0D8FDC76]
	DEFAULT ((0)) FOR [AU_AuditType]
GO
ALTER TABLE [dbo].[Audit] SET (LOCK_ESCALATION = TABLE)
GO
