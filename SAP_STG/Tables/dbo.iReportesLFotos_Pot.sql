SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iReportesLFotos_Pot] (
		[IdRegistro]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEmpresa]            [int] NOT NULL,
		[nomIPad]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codReporte]            [int] NOT NULL,
		[linReportesLFotos]     [int] NOT NULL,
		[imgFoto]               [image] NULL,
		[FechaAlta]             [datetime] NOT NULL,
		[Estado]                [tinyint] NULL,
		CONSTRAINT [PK_iReportesLFotos_Pot]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[iReportesLFotos_Pot] SET (LOCK_ESCALATION = TABLE)
GO
