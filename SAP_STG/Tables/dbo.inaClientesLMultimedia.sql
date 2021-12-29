SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaClientesLMultimedia] (
		[CodEmpresa]           [int] NOT NULL,
		[ID]                   [int] IDENTITY(1, 1) NOT NULL,
		[CodAreaManager]       [int] NULL,
		[CodDelegacion]        [int] NULL,
		[CodAgente]            [int] NULL,
		[CodGrupoClientes]     [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodProvincia]         [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodCliente]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[hipMultimedia]        [varchar](600) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desMultimedia]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_inaClientesLMultimedia]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaClientesLMultimedia]
	ADD
	CONSTRAINT [DF_inaClientesLMultimedia_CodEmpresa]
	DEFAULT ((2)) FOR [CodEmpresa]
GO
ALTER TABLE [dbo].[inaClientesLMultimedia] SET (LOCK_ESCALATION = TABLE)
GO
