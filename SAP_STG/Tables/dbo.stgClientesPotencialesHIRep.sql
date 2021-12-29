SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgClientesPotencialesHIRep] (
		[CodEmpresa]           [int] NOT NULL,
		[CodCliente]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodAgente]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FecReporte]           [datetime] NOT NULL,
		[Actividad]            [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProveedorActual]      [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Marca]                [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FancyMarca]           [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KilosAño]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KilosSemana]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PrecioMedio]          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ContratoVigente]      [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaFinContrato]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TipoContrato]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Aval]                 [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumComerciales]       [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumClientes]          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumClientesCafe]      [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumCltesContrato]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Inversion]            [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TipoInversion]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SAT]                  [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Marketing]            [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Oportunidades]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Notas]                [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RowId]                [int] NULL,
		CONSTRAINT [PK_stgClientesPotencialesHIRep]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgClientesPotencialesHIRep] SET (LOCK_ESCALATION = TABLE)
GO
