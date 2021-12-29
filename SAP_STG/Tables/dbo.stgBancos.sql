SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgBancos] (
		[CodBanco]     [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Banco]        [char](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_stgBancos]
		PRIMARY KEY
		CLUSTERED
		([CodBanco])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgBancos] SET (LOCK_ESCALATION = TABLE)
GO
