SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaArticulosLMultimedia] (
		[CodEmpresa]          [int] NOT NULL,
		[ID]                  [int] IDENTITY(1, 1) NOT NULL,
		[CodFamilia]          [int] NULL,
		[CodSubFamilia]       [int] NULL,
		[CodTipoArticulo]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodMarca]            [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodArticulo]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[hipMultimedia]       [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[desMultimedia]       [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BajoDemanda]         [tinyint] NULL,
		CONSTRAINT [PK_inaArticulosLMultimedia]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaArticulosLMultimedia] SET (LOCK_ESCALATION = TABLE)
GO
