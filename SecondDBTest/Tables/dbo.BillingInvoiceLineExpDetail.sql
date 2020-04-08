SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingInvoiceLineExpDetail] (
		[BIED_Key]                 [int] IDENTITY(1, 1) NOT NULL,
		[BI_Key]                   [int] NOT NULL,
		[BIL_Key]                  [int] NOT NULL,
		[BCD_Key]                  [int] NOT NULL,
		[BIED_Date]                [float] NOT NULL,
		[RE_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TY_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BIED_ActualVATRate]       [float] NULL,
		[BIED_NetSystemCharge]     [float] NULL,
		[BIED_NetLocalCharge]      [float] NULL,
		[BIED_InvoiceVATRate]      [float] NULL,
		CONSTRAINT [PK__BillingI__F0534B6E55009F39]
		PRIMARY KEY
		CLUSTERED
		([BIED_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BCD_K__6265874F]
	FOREIGN KEY ([BCD_Key]) REFERENCES [dbo].[BillingContractLineDetails] ([BCD_Key])
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	CHECK CONSTRAINT [FK__BillingIn__BCD_K__6265874F]

GO
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BI_Ke__6359AB88]
	FOREIGN KEY ([BI_Key]) REFERENCES [dbo].[BillingInvoice] ([BI_Key])
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	CHECK CONSTRAINT [FK__BillingIn__BI_Ke__6359AB88]

GO
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BIL_K__644DCFC1]
	FOREIGN KEY ([BIL_Key]) REFERENCES [dbo].[BillingInvoiceLine] ([BIL_Key])
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	CHECK CONSTRAINT [FK__BillingIn__BIL_K__644DCFC1]

GO
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__RE_Co__6541F3FA]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	CHECK CONSTRAINT [FK__BillingIn__RE_Co__6541F3FA]

GO
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__TY_Co__66361833]
	FOREIGN KEY ([TY_Code]) REFERENCES [dbo].[Type] ([TY_Code])
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail]
	CHECK CONSTRAINT [FK__BillingIn__TY_Co__66361833]

GO
ALTER TABLE [dbo].[BillingInvoiceLineExpDetail] SET (LOCK_ESCALATION = TABLE)
GO
