SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TVBUR] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKBUR]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADRNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TXNAM_ADR]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TXNAM_KOP]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TXNAM_FUS]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TXNAM_GRU]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TXNAM_SDB]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ISPVKBURUE]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_TVBUR]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [VKBUR])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TVBUR] SET (LOCK_ESCALATION = TABLE)
GO
