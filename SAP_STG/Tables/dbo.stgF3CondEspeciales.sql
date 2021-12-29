SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3CondEspeciales] (
		[CodEmpresa]            [int] NOT NULL,
		[CodCanal]              [int] NOT NULL,
		[CodCliente]            [int] NOT NULL,
		[CodTarifa]             [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodClaseCondicion]     [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo]           [int] NOT NULL,
		[PrecioTarifaFinal]     [money] NOT NULL,
		[FechaIni]              [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaFin]              [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ImpPorc]               [money] NOT NULL,
		[IndPorc]               [numeric](5, 0) NOT NULL,
		[Neto]                  [money] NOT NULL,
		[CodArtObs]             [int] NOT NULL,
		[CantBase]              [int] NOT NULL,
		[CantRegalo]            [int] NOT NULL,
		[create_timestamp]      [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3CondEspeciales]
	ADD
	CONSTRAINT [DF_stgF3CondEspeciales_CodClaseCondicion]
	DEFAULT ('N/A') FOR [CodClaseCondicion]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3CondEspeciales_7_568389094__K3_K5_K2_10_11_13_14]
	ON [dbo].[stgF3CondEspeciales] ([CodCliente], [CodArticulo], [CodCanal])
	INCLUDE ([IndPorc], [Neto], [CantBase], [CantRegalo])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3CondEspeciales] SET (LOCK_ESCALATION = TABLE)
GO
