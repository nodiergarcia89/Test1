SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgBudgetVentas] (
		[CodTipoBudget]        [smallint] NOT NULL,
		[Año]                  [smallint] NOT NULL,
		[Mes]                  [smallint] NOT NULL,
		[CodDelegacion]        [int] NOT NULL,
		[CodPersonal]          [int] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[TipoBudget]           [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KilosCafe]            [numeric](11, 2) NOT NULL,
		[FactCafe]             [money] NOT NULL,
		[FactCompl]            [money] NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		[update_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_stgBudgetVentas_1]
		PRIMARY KEY
		CLUSTERED
		([CodTipoBudget], [Año], [Mes], [CodDelegacion], [CodPersonal], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgBudgetVentas]
	ADD
	CONSTRAINT [DF_stgBudgetVentas_CodDelegacion]
	DEFAULT ((0)) FOR [CodDelegacion]
GO
ALTER TABLE [dbo].[stgBudgetVentas]
	ADD
	CONSTRAINT [DF_stgBudgetVentas_CodPersonal]
	DEFAULT ((0)) FOR [CodPersonal]
GO
ALTER TABLE [dbo].[stgBudgetVentas]
	ADD
	CONSTRAINT [DF_stgBudgetVentas_CodCliente]
	DEFAULT ((0)) FOR [CodCliente]
GO
ALTER TABLE [dbo].[stgBudgetVentas]
	ADD
	CONSTRAINT [DF_stgBudgetVentas_KilosCafe]
	DEFAULT ((0)) FOR [KilosCafe]
GO
ALTER TABLE [dbo].[stgBudgetVentas]
	ADD
	CONSTRAINT [DF_stgBudgetVentas_FactCafe]
	DEFAULT ((0)) FOR [FactCafe]
GO
ALTER TABLE [dbo].[stgBudgetVentas]
	ADD
	CONSTRAINT [DF_stgBudgetVentas_FactComl]
	DEFAULT ((0)) FOR [FactCompl]
GO
ALTER TABLE [dbo].[stgBudgetVentas] SET (LOCK_ESCALATION = TABLE)
GO
