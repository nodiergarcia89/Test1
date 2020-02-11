SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvoiceExchangeRate] (
		[IH_Key]                 [int] NOT NULL,
		[CU_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IER_CalculatedRate]     [float] NOT NULL,
		[IER_AdjustedRate]       [float] NOT NULL,
		CONSTRAINT [PK__InvoiceE__12EA7C1A34E8D562]
		PRIMARY KEY
		CLUSTERED
		([IH_Key], [CU_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[InvoiceExchangeRate] SET (LOCK_ESCALATION = TABLE)
GO
