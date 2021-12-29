SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3ResumenDeudaClientes] (
		[CodEmpresa]            [int] NOT NULL,
		[CodCliente]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DeudaAsegurada]        [money] NOT NULL,
		[TotalDeuda]            [money] NOT NULL,
		[DeudaComprometida]     [money] NOT NULL,
		[DeudaTotal]            [money] NOT NULL,
		[DeudaVencida]          [money] NOT NULL,
		[DeudaNoVencida]        [money] NOT NULL,
		[DeudaImpagada]         [money] NOT NULL,
		[create_timestamp]      [datetime] NOT NULL,
		CONSTRAINT [PK_stgF3ResumenDeudaClientes]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3ResumenDeudaClientes_7_683149479__K1]
	ON [dbo].[stgF3ResumenDeudaClientes] ([CodEmpresa])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3ResumenDeudaClientes_7_683149479__K1_2_3_6_7_9]
	ON [dbo].[stgF3ResumenDeudaClientes] ([CodEmpresa])
	INCLUDE ([CodCliente], [DeudaAsegurada], [DeudaTotal], [DeudaVencida], [DeudaImpagada])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3ResumenDeudaClientes] SET (LOCK_ESCALATION = TABLE)
GO
