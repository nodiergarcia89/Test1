SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgF3CosteSAT] (
		[CodEmpresa]           [tinyint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[Ordenes]              [smallint] NULL,
		[Coste]                [money] NULL,
		[CosteM]               [money] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF3CosteSAT]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3CosteSAT] SET (LOCK_ESCALATION = TABLE)
GO
