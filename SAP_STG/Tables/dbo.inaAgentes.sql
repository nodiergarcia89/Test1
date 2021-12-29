SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaAgentes] (
		[CodEmpresa]      [int] NOT NULL,
		[CodAgente]       [int] NOT NULL,
		[Nombre]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Promotor]        [bit] NULL,
		[ATC]             [bit] NULL,
		[Delegado]        [bit] NULL,
		[AreaManager]     [bit] NULL,
		[DirCentral]      [bit] NULL,
		[Race]            [bit] NULL,
		[CodCatalogo]     [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Ina]             [bit] NOT NULL,
		[Tablet]          [bit] NOT NULL,
		[Pedidos]         [bit] NULL,
		CONSTRAINT [PK_inaAgentes]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodAgente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaAgentes]
	ADD
	CONSTRAINT [DF_inaAgentes_Race]
	DEFAULT ((0)) FOR [Race]
GO
ALTER TABLE [dbo].[inaAgentes]
	ADD
	CONSTRAINT [DF_inaAgentes_Tablet]
	DEFAULT ((0)) FOR [Tablet]
GO
ALTER TABLE [dbo].[inaAgentes]
	ADD
	CONSTRAINT [DF_inaAgentes_Pedidos]
	DEFAULT ((0)) FOR [Pedidos]
GO
ALTER TABLE [dbo].[inaAgentes] SET (LOCK_ESCALATION = TABLE)
GO
