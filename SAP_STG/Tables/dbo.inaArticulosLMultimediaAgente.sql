SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaArticulosLMultimediaAgente] (
		[CodEmpresa]         [int] NOT NULL,
		[ID]                 [int] IDENTITY(1, 1) NOT NULL,
		[CodAreaManager]     [int] NULL,
		[CodDelegacion]      [smallint] NULL,
		[CodAgente]          [int] NULL,
		[Race]               [bit] NULL,
		[DirCentral]         [bit] NULL,
		[hipMultimedia]      [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[desMultimedia]      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Tratar]             [bit] NOT NULL,
		[BajoDemanda]        [tinyint] NOT NULL,
		CONSTRAINT [PK_inaArticulosLMultimediaAgente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaArticulosLMultimediaAgente]
	ADD
	CONSTRAINT [DF_inaArticulosLMultimediaAgente_Tratar]
	DEFAULT ((0)) FOR [Tratar]
GO
ALTER TABLE [dbo].[inaArticulosLMultimediaAgente]
	ADD
	CONSTRAINT [DF_inaArticulosLMultimediaAgente_BajoDemanda]
	DEFAULT ((0)) FOR [BajoDemanda]
GO
ALTER TABLE [dbo].[inaArticulosLMultimediaAgente] SET (LOCK_ESCALATION = TABLE)
GO
