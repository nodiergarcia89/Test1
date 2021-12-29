SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SourceSystems] (
		[IdSourceSystem]              [tinyint] NOT NULL,
		[SourceSystemName]            [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SourceSystemDescription]     [char](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ConnectionString]            [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Mandante]                    [int] NOT NULL,
		CONSTRAINT [PK_SourceSystems]
		PRIMARY KEY
		CLUSTERED
		([IdSourceSystem])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SourceSystems]
	ADD
	CONSTRAINT [DF_SourceSystems_Mandante]
	DEFAULT ((0)) FOR [Mandante]
GO
ALTER TABLE [dbo].[SourceSystems] SET (LOCK_ESCALATION = TABLE)
GO
