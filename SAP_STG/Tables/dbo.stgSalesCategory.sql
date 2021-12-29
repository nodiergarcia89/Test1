SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgSalesCategory] (
		[CodEmpresa]                [int] NOT NULL,
		[MANDT]                     [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoCliente]            [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodSalesCategoryGroup]     [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SalesCategoryGroup]        [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodSalesCategoryUT]        [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SalesCategoryUT]           [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]          [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgSalesCategory] SET (LOCK_ESCALATION = TABLE)
GO
