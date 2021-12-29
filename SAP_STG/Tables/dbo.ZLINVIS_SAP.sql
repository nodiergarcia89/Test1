SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZLINVIS_SAP] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLCNDO]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLTIDE]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLNNOR]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLNND0]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLCND1]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLCADE]               [numeric](8, 2) NOT NULL,
		[VLPRUN]               [numeric](9, 3) NOT NULL,
		[VLDESN]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ACCION]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ERSDA]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UZBER]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_ZLINVIS_SAP]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [MANDT], [VLCNDO], [VLTIDE], [VLNNOR], [VLNND0])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZLINVIS_SAP] SET (LOCK_ESCALATION = TABLE)
GO
