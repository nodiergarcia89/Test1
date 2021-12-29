SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZSD034] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR1]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZCRM]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZFOL]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZHAS]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZB2B]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]     [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZSD034] SET (LOCK_ESCALATION = TABLE)
GO
