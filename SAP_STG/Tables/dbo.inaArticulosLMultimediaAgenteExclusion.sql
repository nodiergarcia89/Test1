SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaArticulosLMultimediaAgenteExclusion] (
		[CodEmpresa]        [int] NOT NULL,
		[CodAgente]         [int] NOT NULL,
		[hipMultimedia]     [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_inaArticulosLMultimediaAgenteExclusion]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodAgente], [hipMultimedia])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaArticulosLMultimediaAgenteExclusion]
	ADD
	CONSTRAINT [DF_inaArticulosLMultimediaAgenteExclusion_CodEmpresa]
	DEFAULT ((2)) FOR [CodEmpresa]
GO
ALTER TABLE [dbo].[inaArticulosLMultimediaAgenteExclusion] SET (LOCK_ESCALATION = TABLE)
GO
