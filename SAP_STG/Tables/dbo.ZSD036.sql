SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZSD036] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RACE]                 [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BZIRK]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZSD036] SET (LOCK_ESCALATION = TABLE)
GO
