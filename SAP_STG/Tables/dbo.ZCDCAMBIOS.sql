SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZCDCAMBIOS] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBJECTCLAS]           [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBJECTID]             [nvarchar](90) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CHANGENR]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[USERNAME]             [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UDATE]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UTIME]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TCODE]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TABNAME]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TABKEY]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FNAME]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CHNGIND]              [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VALUE_NEW]            [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VALUE_OLD]            [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHAPROCESO]         [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HORAPROCESO]          [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_ZCDCAMBIOS]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [OBJECTCLAS], [OBJECTID], [CHANGENR], [USERNAME], [UDATE], [UTIME], [TCODE], [TABNAME], [TABKEY], [FNAME], [CHNGIND])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCDCAMBIOS] SET (LOCK_ESCALATION = TABLE)
GO
