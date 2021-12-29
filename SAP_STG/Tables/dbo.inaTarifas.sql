SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaTarifas] (
		[CodTarifa]     [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tarifa]        [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Folleto]       [bit] NOT NULL,
		[TipoCarga]     [smallint] NOT NULL,
		[Ubicacion]     [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_inaTarifas]
		PRIMARY KEY
		CLUSTERED
		([CodTarifa])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaTarifas]
	ADD
	CONSTRAINT [DF_inaTarifas_Folleto]
	DEFAULT ((1)) FOR [Folleto]
GO
ALTER TABLE [dbo].[inaTarifas]
	ADD
	CONSTRAINT [DF_inaTarifas_TipoCarga]
	DEFAULT ((0)) FOR [TipoCarga]
GO
ALTER TABLE [dbo].[inaTarifas] SET (LOCK_ESCALATION = TABLE)
GO
