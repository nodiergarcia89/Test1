SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MAKT] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATNR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MAKTX]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MAKTG]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_MAKT]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [MATNR], [SPRAS])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MAKT_7_1829581556__K2_K3]
	ON [dbo].[MAKT] ([MANDT], [MATNR])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MAKT_7_1829581556__K2_K3_6]
	ON [dbo].[MAKT] ([MANDT], [MATNR])
	INCLUDE ([MAKTG])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MAKT] SET (LOCK_ESCALATION = TABLE)
GO
