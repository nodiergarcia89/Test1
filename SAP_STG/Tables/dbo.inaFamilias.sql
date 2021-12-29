SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaFamilias] (
		[CodEmpresa]           [int] NOT NULL,
		[codFamilia]           [int] NOT NULL,
		[codSubFamilia]        [int] NOT NULL,
		[desFamilia]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ordFamilia]           [int] NOT NULL,
		[JerarquiaSAP]         [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NuevaDescripcion]     [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[nomIcoFamilia]        [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumArticulos]         [int] NOT NULL,
		[Ina]                  [int] NOT NULL,
		CONSTRAINT [PK_inaFamilias]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [codFamilia], [codSubFamilia])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaFamilias]
	ADD
	CONSTRAINT [DF_inaFamilias_NumArticulos]
	DEFAULT ((0)) FOR [NumArticulos]
GO
ALTER TABLE [dbo].[inaFamilias] SET (LOCK_ESCALATION = TABLE)
GO
