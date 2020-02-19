SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvoiceTemplate] (
		[IT_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IT_Description]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IT_HeaderImage]             [varbinary](max) NULL,
		[IT_FooterImage]             [varbinary](max) NULL,
		[IT_XmlDefinition]           [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IT_HeaderImageFileName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IT_FooterImageFileName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IT_IsDefault]               [smallint] NOT NULL,
		[US_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IT_LastEditDate]            [float] NULL,
		CONSTRAINT [PK__InvoiceT__2A052F4A3C89F72A]
		PRIMARY KEY
		CLUSTERED
		([IT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[InvoiceTemplate]
	ADD
	CONSTRAINT [DF__InvoiceTe__IT_Is__3E723F9C]
	DEFAULT ((-1)) FOR [IT_IsDefault]
GO
ALTER TABLE [dbo].[InvoiceTemplate] SET (LOCK_ESCALATION = TABLE)
GO
