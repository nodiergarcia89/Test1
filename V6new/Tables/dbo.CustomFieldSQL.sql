SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomFieldSQL] (
		[CF_Key]                [int] NOT NULL,
		[CF_SQL]                [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_SQLDescription]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_PortableSQL]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_SQLVersion]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__CustomFi__8E3AED2E075714DC]
		PRIMARY KEY
		CLUSTERED
		([CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomFieldSQL]
	WITH CHECK
	ADD CONSTRAINT [FK__CustomFie__CF_Ke__24334AAC]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[CustomFieldSQL]
	CHECK CONSTRAINT [FK__CustomFie__CF_Ke__24334AAC]

GO
ALTER TABLE [dbo].[CustomFieldSQL] SET (LOCK_ESCALATION = TABLE)
GO
