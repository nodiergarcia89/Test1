SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgdim_Personal] (
		[CodEmpresa]                    [smallint] NOT NULL,
		[CodPersonal]                   [int] NOT NULL,
		[NombreCompleto]                [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NombreCompleto2]               [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacion_key]             [int] NOT NULL,
		[ATC]                           [bit] NOT NULL,
		[Autoventa]                     [bit] NOT NULL,
		[Vending]                       [bit] NOT NULL,
		[SAT]                           [bit] NOT NULL,
		[Almacenero]                    [bit] NOT NULL,
		[Promotor]                      [bit] NOT NULL,
		[RACE]                          [bit] NOT NULL,
		[Delegado]                      [bit] NOT NULL,
		[AreaManager]                   [bit] NOT NULL,
		[Central]                       [bit] NOT NULL,
		[Baja]                          [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UserId]                        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IdUserSAP]                     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Oficina]                       [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumTelefono]                   [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumMovil]                      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPN]                           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CargoCompleto]                 [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FotoUsuario]                   [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Cargo]                         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaNacimiento]               [int] NOT NULL,
		[Edad]                          [smallint] NOT NULL,
		[CumpleHoy]                     [bit] NOT NULL,
		[FechaIniEmp]                   [int] NOT NULL,
		[FechaFinEmp]                   [int] NOT NULL,
		[FechaAlta]                     [int] NOT NULL,
		[Antiguedad]                    [smallint] NOT NULL,
		[Departamento]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Empresa]                       [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Email]                         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Extension]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Direccion]                     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Poblacion]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CP]                            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Pais]                          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Provincia]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IdResponsable]                 [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Responsable]                   [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DNI]                           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UTOInterno]                    [bit] NOT NULL,
		[UTO_Interno]                   [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UTOExterno]                    [bit] NOT NULL,
		[UTO_Externo]                   [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Acceso_UTO]                    [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tablet]                        [bit] NOT NULL,
		[Tiene_Tablet]                  [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_Tablet]                 [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Nombre_Tablet]                 [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BlackBerry]                    [bit] NOT NULL,
		[Tiene_BlackBerry]              [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_BlackBerry]             [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ModemUSB]                      [bit] NOT NULL,
		[Tiene_ModemUSB]                [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_ModemUSB]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Smartphone]                    [bit] NOT NULL,
		[Tiene_Smartphone]              [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_Smartphone]             [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Movil]                         [bit] NOT NULL,
		[Tiene_Movil]                   [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_Movil]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PDAAutoventa]                  [bit] NOT NULL,
		[Tiene_PDAAutoventa]            [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_PDAAutoventa]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Nombre_PDAAutoventa]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LineaCasa]                     [bit] NOT NULL,
		[Tiene_LineaCasa]               [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Portatil]                      [bit] NOT NULL,
		[Tiene_Portatil]                [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_Portatil]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Nombre_Portatil]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SO_Portatil]                   [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LastSeen_Portatil]             [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FirstSeen_Portatil]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EquipoSobremesa]               [bit] NOT NULL,
		[Tiene_EquipoSobremesa]         [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo_EquipoSobremesa]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Nombre_EquipoSobremesa]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SO_EquipoSobremesa]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LastSeen_EquipoSobremesa]      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FirstSeen_EquipoSobremesa]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tiene_DispositivoMovil]        [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tiene_Equipo]                  [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoUsuarioTFS]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LogoEmpresa]                   [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EnlaceLansweeper]              [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]              [datetime] NOT NULL,
		CONSTRAINT [PK_stgdim_Personal_1]
		PRIMARY KEY
		CLUSTERED
		([CodPersonal])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgdim_Personal]
	ADD
	CONSTRAINT [DF_stgdim_Personal_IdUserSAP]
	DEFAULT ('N/A') FOR [IdUserSAP]
GO
ALTER TABLE [dbo].[stgdim_Personal] SET (LOCK_ESCALATION = TABLE)
GO
