SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3ConsumosClienteMA] (
		[CodEmpresa]           [int] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[CodNivel1]            [int] NULL,
		[Nivel1]               [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Consumo]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]     [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3ConsumosClienteMA] SET (LOCK_ESCALATION = TABLE)
GO
