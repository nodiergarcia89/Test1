SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dim_Fecha] (
		[Fecha_key]            [int] NOT NULL,
		[idFecha]              [int] NULL,
		[FechaCompleta]        [datetime] NULL,
		[Fecha]                [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DiaSemana]            [int] NULL,
		[DiaSemanaTxt]         [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Mes]                  [tinyint] NULL,
		[MesTxt]               [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Año]                  [smallint] NULL,
		[Dia]                  [tinyint] NULL,
		[Semana]               [smallint] NULL,
		[SemanaNat]            [int] NULL,
		[Trimestre]            [tinyint] NULL,
		[SemanaTxt]            [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TrimestreTxt]         [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PeriodoSAP]           [int] NULL,
		[PeriodoSAPAnt]        [int] NULL,
		[Es_Festivo]           [tinyint] NULL,
		[Festivo]              [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PeriodoSAPtxt]        [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Es_Laborable]         [tinyint] NULL,
		[Laborable]            [char](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Estacion]             [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Evento]               [char](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Es_FinMes]            [bit] NULL,
		[Es_IniMes]            [bit] NULL,
		[Dias_Mes]             [tinyint] NULL,
		[Dias_FinMes]          [tinyint] NULL,
		[Es_Hoy]               [int] NULL,
		[Es_6mAtras]           [int] NULL,
		[Es_3mAtras]           [int] NULL,
		[Es_1mAtras]           [int] NULL,
		[Es_1aAtras]           [int] NULL,
		[fromdate]             [datetime] NULL,
		[todate]               [datetime] NULL,
		[$sq_row_hash_T1]      [bigint] NULL,
		[$sq_row_hash_T2]      [bigint] NULL,
		[$sq_row_hash_T1h]     [bigint] NULL,
		[$sq_row_hash]         [bigint] NULL,
		[$sq_execution_id]     [bigint] NOT NULL,
		CONSTRAINT [PK_dim_Fecha]
		PRIMARY KEY
		CLUSTERED
		([Fecha_key])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dim_Fecha] SET (LOCK_ESCALATION = TABLE)
GO
