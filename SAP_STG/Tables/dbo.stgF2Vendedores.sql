SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2Vendedores] (
		[CodEmpresa]           [int] NOT NULL,
		[CodVendedor]          [int] NOT NULL,
		[FechaIniEmp]          [date] NOT NULL,
		[FechaFinEmp]          [date] NOT NULL,
		[NombreCompleto]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UserName]             [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IdUserSAP]            [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FotoUsuario]          [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacion]        [smallint] NOT NULL,
		[Notificar]            [int] NOT NULL,
		[Terminal]             [int] NOT NULL,
		[ATC]                  [int] NOT NULL,
		[Autoventa]            [int] NOT NULL,
		[Vending]              [int] NOT NULL,
		[SAT]                  [int] NOT NULL,
		[Almacenero]           [int] NOT NULL,
		[Promotor]             [int] NOT NULL,
		[RACE]                 [int] NOT NULL,
		[Delegado]             [int] NOT NULL,
		[AreaManager]          [int] NOT NULL,
		[Central]              [int] NOT NULL,
		[Telefono]             [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Baja]                 [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Email]                [char](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tablet]               [int] NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_stgF2Vendedores]
		PRIMARY KEY
		CLUSTERED
		([CodVendedor])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2Vendedores]
	ADD
	CONSTRAINT [DF_stgF2Vendedores_UserName]
	DEFAULT ('N/A') FOR [UserName]
GO
ALTER TABLE [dbo].[stgF2Vendedores]
	ADD
	CONSTRAINT [DF_stgF2Vendedores_IdUserSAP]
	DEFAULT ('N/A') FOR [IdUserSAP]
GO
ALTER TABLE [dbo].[stgF2Vendedores]
	ADD
	CONSTRAINT [DF_stgF2Vendedores_FotoUsuario]
	DEFAULT ('N/A') FOR [FotoUsuario]
GO
ALTER TABLE [dbo].[stgF2Vendedores]
	ADD
	CONSTRAINT [DF_stgF2Vendedores_Tablet]
	DEFAULT ((0)) FOR [Tablet]
GO
ALTER TABLE [dbo].[stgF2Vendedores]
	ADD
	CONSTRAINT [DF_stgF2Vendedores_create_timestamp]
	DEFAULT ((0)) FOR [create_timestamp]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2Vendedores_7_1991678143__K2_5]
	ON [dbo].[stgF2Vendedores] ([CodVendedor])
	INCLUDE ([NombreCompleto])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2Vendedores_7_838294046__K1_K2_K8_5_6_7_11_16_18_19_20]
	ON [dbo].[stgF2Vendedores] ([CodEmpresa], [CodVendedor], [CodDelegacion])
	INCLUDE ([NombreCompleto], [UserName], [FotoUsuario], [ATC], [Promotor], [Delegado], [AreaManager], [Central])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2Vendedores_8_1144391146__K9_K2]
	ON [dbo].[stgF2Vendedores] ([CodDelegacion], [CodVendedor])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2Vendedores] SET (LOCK_ESCALATION = TABLE)
GO
