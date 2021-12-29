SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3ConsumosClienteA] (
		[CodEmpresa]           [int] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[CodNivel1]            [int] NOT NULL,
		[Nivel1]               [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Consumo]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_stgF3ConsumosClienteA]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente], [CodNivel1])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3ConsumosClienteA] SET (LOCK_ESCALATION = TABLE)
GO
