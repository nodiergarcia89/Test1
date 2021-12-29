SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgProvincias] (
		[CodProvincia]     [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Provincia]        [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_stgProvincias]
		PRIMARY KEY
		CLUSTERED
		([CodProvincia])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgProvincias] SET (LOCK_ESCALATION = TABLE)
GO
