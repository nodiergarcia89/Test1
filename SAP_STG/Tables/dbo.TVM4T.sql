SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TVM4T] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR4]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BEZEI]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_TVM4T]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [SPRAS], [MVGR4])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TVM4T] SET (LOCK_ESCALATION = TABLE)
GO
