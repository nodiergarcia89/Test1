SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DD01T] (
		[CodEmpresa]           [int] NOT NULL,
		[DOMNAME]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DDLANGUAGE]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AS4LOCAL]             [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AS4VERS]              [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DDTEXT]               [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_DD01T]
		PRIMARY KEY
		CLUSTERED
		([DOMNAME], [DDLANGUAGE], [AS4LOCAL], [AS4VERS])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DD01T] SET (LOCK_ESCALATION = TABLE)
GO
