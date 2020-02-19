SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingInvoiceLineTSDetail] (
		[BITD_Key]                         [int] IDENTITY(1, 1) NOT NULL,
		[BI_Key]                           [int] NOT NULL,
		[BIL_Key]                          [int] NOT NULL,
		[BCD_Key]                          [int] NOT NULL,
		[BITD_Date]                        [float] NOT NULL,
		[RE_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BITD_Count]                       [int] NOT NULL,
		[BITD_ActualUnits]                 [float] NOT NULL,
		[BITD_ActualSystemCharge]          [float] NOT NULL,
		[BITD_ActualLocalCharge]           [float] NOT NULL,
		[BITD_BillingRuleUnits]            [float] NOT NULL,
		[BITD_BillingRuleSystemCharge]     [float] NOT NULL,
		[BITD_BillingRuleLocalCharge]      [float] NOT NULL,
		[AC_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_Key]                           [int] NULL,
		CONSTRAINT [PK__BillingI__FBD134B658D1301D]
		PRIMARY KEY
		CLUSTERED
		([BITD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__AC_Co__672A3C6C]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__AC_Co__672A3C6C]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BCD_K__681E60A5]
	FOREIGN KEY ([BCD_Key]) REFERENCES [dbo].[BillingContractLineDetails] ([BCD_Key])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__BCD_K__681E60A5]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BI_Ke__691284DE]
	FOREIGN KEY ([BI_Key]) REFERENCES [dbo].[BillingInvoice] ([BI_Key])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__BI_Ke__691284DE]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BIL_K__6A06A917]
	FOREIGN KEY ([BIL_Key]) REFERENCES [dbo].[BillingInvoiceLine] ([BIL_Key])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__BIL_K__6A06A917]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__DE_Co__6AFACD50]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__DE_Co__6AFACD50]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__RE_Co__6BEEF189]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__RE_Co__6BEEF189]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__TA_Ke__6CE315C2]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail]
	CHECK CONSTRAINT [FK__BillingIn__TA_Ke__6CE315C2]

GO
ALTER TABLE [dbo].[BillingInvoiceLineTSDetail] SET (LOCK_ESCALATION = TABLE)
GO
