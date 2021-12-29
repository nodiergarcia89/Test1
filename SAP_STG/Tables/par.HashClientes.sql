SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [par].[HashClientes] (
		[Variable]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Valor]           [int] NOT NULL,
		[Hashtag]         [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodMarca]        [int] NULL,
		[Descripcion]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DesMarca]        [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[codTipo]         [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [par].[HashClientes] SET (LOCK_ESCALATION = TABLE)
GO
