SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2Clientes] (
		[CodEmpresa]                [int] NOT NULL,
		[CodCliente]                [int] NOT NULL,
		[NombreCliente]             [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Direccion]                 [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Poblacion]                 [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CP]                        [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodPais]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Pais]                      [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodProvincia]              [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Provincia]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Telefono]                  [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Fax]                       [nvarchar](31) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaCreacionRegistro]     [date] NULL,
		[CodGrupoClientes]          [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GrupoClientes]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DireccionEmail]            [nvarchar](241) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Baja]                      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacionOrigen]       [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DelegacionOrigen]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]          [datetime] NOT NULL,
		CONSTRAINT [PK_stgF2Clientes]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2Clientes] SET (LOCK_ESCALATION = TABLE)
GO
