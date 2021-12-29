SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IHPA] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBJNR]                [nvarchar](22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PARVW]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COUNTER]              [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBTYP]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PARNR]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[INHER]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERZEIT]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AEDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AEZEIT]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AENAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZLOESCH]             [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADRNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TZONSP]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_IHPA]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [MANDT], [OBJNR], [PARVW], [COUNTER])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IHPA] SET (LOCK_ESCALATION = TABLE)
GO
