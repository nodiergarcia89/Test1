SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZXONE23] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERNR]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LGORT]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_ZXONE23]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [MANDT], [PERNR])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZXONE23] SET (LOCK_ESCALATION = TABLE)
GO
