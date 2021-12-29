SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T171T] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BZIRK]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BZTXT]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_T171T]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [SPRAS], [BZIRK])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T171T] SET (LOCK_ESCALATION = TABLE)
GO
