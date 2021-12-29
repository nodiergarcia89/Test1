SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgClientesPotencialesRep] (
		[CodEmpresa]                 [int] NOT NULL,
		[CodCliente]                 [int] NOT NULL,
		[CodClienteIni]              [int] NULL,
		[CodAgente]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FecReporte]                 [datetime] NOT NULL,
		[ProveedorActual]            [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ContratoVigente]            [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaFinContrato]           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Maquina]                    [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ModeloMaquina]              [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TipoContrato]               [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OtroTipoInversion]          [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KilosSemana]                [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Precio]                     [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GamaProductoActual]         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MarketingPLV]               [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KilosAño]                   [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ActividadPrincipal]         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumeroEstablecimientos]     [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MarcaPropia]                [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NombreMarcaPropia]          [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PropiedadCliente]           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Personal]                   [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RowId]                      [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgClientesPotencialesRep_7_1711345161__K2_5_6_12_16]
	ON [dbo].[stgClientesPotencialesRep] ([CodCliente])
	INCLUDE ([ProveedorActual], [ContratoVigente], [KilosSemana], [KilosAño])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgClientesPotencialesRep] SET (LOCK_ESCALATION = TABLE)
GO
