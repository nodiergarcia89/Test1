SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T023T] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATKL]                [nvarchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WGBEZ]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WGBEZ60]              [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_T023T]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [SPRAS], [MATKL])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T023T] SET (LOCK_ESCALATION = TABLE)
GO
