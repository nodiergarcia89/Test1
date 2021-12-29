SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T005U] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LAND1]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BLAND]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BEZEI]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_T005U]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [SPRAS], [LAND1], [BLAND])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_T005U_7_562101043__K3_2_4_5_6]
	ON [dbo].[T005U] ([SPRAS])
	INCLUDE ([MANDT], [LAND1], [BLAND], [BEZEI])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[T005U] SET (LOCK_ESCALATION = TABLE)
GO
