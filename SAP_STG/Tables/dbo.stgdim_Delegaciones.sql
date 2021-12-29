SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgdim_Delegaciones] (
		[CodEmpresa]              [smallint] NOT NULL,
		[CodDelegacion]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Delegacion]              [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Delegacion_Completo]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Direccion]               [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DireccionAdicional]      [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Poblacion]               [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CP]                      [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodProvincia]            [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Provincia]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Telefono]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Extension]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Fax]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArea]                 [tinyint] NULL,
		[Area]                    [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodDelegado]             [int] NULL,
		[CodAreaManager]          [int] NULL,
		[create_timestamp]        [datetime] NOT NULL,
		CONSTRAINT [PK_stgdim_Delegaciones_1]
		PRIMARY KEY
		CLUSTERED
		([CodDelegacion])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgdim_Delegaciones] SET (LOCK_ESCALATION = TABLE)
GO
