SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3AnalisisVisitas] (
		[CodEmpresa]            [int] NOT NULL,
		[Clave]                 [nvarchar](112) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Dispositivo]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codAgente]             [int] NULL,
		[UserName]              [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FotoUsuario]           [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NombreCompleto]        [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EsPromotor]            [int] NOT NULL,
		[EsATC]                 [int] NOT NULL,
		[EsDelegado]            [int] NOT NULL,
		[EsAreaManager]         [int] NOT NULL,
		[EsCentral]             [int] NOT NULL,
		[CodDelegacion]         [smallint] NOT NULL,
		[Delegacion]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodAreaManager]        [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AreaManager]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodDelegado]           [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Delegado]              [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Reporte]               [int] NOT NULL,
		[FechaVisita]           [datetime] NULL,
		[Fecha]                 [date] NULL,
		[Fecha_key]             [int] NOT NULL,
		[Hora]                  [time](7) NULL,
		[HoraDia]               [int] NULL,
		[Año]                   [smallint] NOT NULL,
		[Trimestre]             [tinyint] NOT NULL,
		[Mes]                   [tinyint] NOT NULL,
		[MesTxt]                [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EsMesActual]           [int] NOT NULL,
		[Semana]                [smallint] NOT NULL,
		[SemanaTxt]             [varchar](37) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DiaSemana]             [int] NOT NULL,
		[DiaSemanaTxt]          [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Dia]                   [tinyint] NOT NULL,
		[Fotos]                 [int] NOT NULL,
		[CodCliente]            [nvarchar](121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Cliente]               [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Provincia]             [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Poblacion]             [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodStatusClte]         [int] NOT NULL,
		[StatusClte]            [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Planificada]           [int] NOT NULL,
		[PlanSigVisita]         [int] NOT NULL,
		[FecSigVisita]          [datetime] NULL,
		[CodTipoVisita]         [int] NULL,
		[TipoVisita]            [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Accion]                [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Observaciones]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DatosActualizados]     [datetime] NULL,
		[create_timestamp]      [datetime] NULL,
		CONSTRAINT [PK_stgF3AnalisisVisitas]
		PRIMARY KEY
		CLUSTERED
		([Clave])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3AnalisisVisitas_7_758293761__K36_K20_2_4_5_7_14_19_21_22_23_24_25_29_30_32_33_34_35_37_38_39_42_43_44_45_46_47_]
	ON [dbo].[stgF3AnalisisVisitas] ([CodCliente], [FechaVisita])
	INCLUDE ([Clave], [codAgente], [UserName], [NombreCompleto], [FecSigVisita], [CodTipoVisita], [TipoVisita], [Accion], [Observaciones], [DatosActualizados], [Fotos], [Cliente], [Provincia], [Poblacion], [Planificada], [PlanSigVisita], [Año], [EsMesActual], [Semana], [DiaSemana], [DiaSemanaTxt], [Dia], [Delegacion], [Reporte], [Fecha], [Fecha_key], [Hora], [HoraDia])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3AnalisisVisitas] SET (LOCK_ESCALATION = TABLE)
GO
