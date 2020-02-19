SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingInvoice] (
		[BI_Key]                             [int] IDENTITY(1, 1) NOT NULL,
		[BI_InvoiceDate]                     [float] NOT NULL,
		[BI_InvoiceNumberPrefix]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_InvoiceNumber]                   [int] NOT NULL,
		[BI_Type]                            [int] NOT NULL,
		[BC_Key]                             [int] NOT NULL,
		[PR_Code]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Desc]                            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Code]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Desc]                            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_VATNumber]                       [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CU_Desc]                            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CU_Symbol]                          [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BI_ExchangeRate]                    [float] NOT NULL,
		[BI_AccountNumber]                   [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_PaymentTerms]                    [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_Reference]                       [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_OrderNumber]                     [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_Notes]                           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactName]                     [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactTelephone]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactAddress1]                 [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactAddress2]                 [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactAddress3]                 [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactAddress4]                 [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactAddress5]                 [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_ContactAddress6]                 [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_Exported]                        [int] NULL,
		[BI_NetCharge]                       [float] NOT NULL,
		[BI_GrossCharge]                     [float] NOT NULL,
		[BI_LastEditDate]                    [float] NOT NULL,
		[US_Code]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BI_FilterFromDate]                  [float] NULL,
		[BI_FilterToDate]                    [float] NULL,
		[BI_Status]                          [int] NULL,
		[BI_TimeFormat]                      [int] NULL,
		[BI_ExpenseFormat]                   [int] NULL,
		[BI_PrintTimesheetDetail]            [int] NULL,
		[BI_PrintExpenseDetail]              [int] NULL,
		[BI_Issued]                          [smallint] NULL,
		[BI_IssuedBy]                        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_IssuedOn]                        [float] NULL,
		[BI_SystemNetCharge]                 [float] NULL,
		[BI_SystemGrossCharge]               [float] NULL,
		[BI_ExportedOn]                      [float] NULL,
		[BI_ExportedBy]                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_AuthorisedOn]                    [float] NULL,
		[BI_AuthorisedBy]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_EditBy]                          [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_EditOn]                          [float] NULL,
		[BI_EditOverwriteBy]                 [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_TimePrintFormat]                 [int] NULL,
		[BI_ExpensePrintFormat]              [int] NULL,
		[BI_SummariseLineGroupingTotals]     [int] NULL,
		[BI_FormatInvoiceNumber]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BIT_Code]                           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_Paid]                            [smallint] NULL,
		[BI_PaidOn]                          [float] NULL,
		[BI_PaidBy]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__BillingI__76F2E4AE498EEC8D]
		PRIMARY KEY
		CLUSTERED
		([BI_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BC_Ke__58DC1D15]
	FOREIGN KEY ([BC_Key]) REFERENCES [dbo].[BillingContract] ([BC_Key])
ALTER TABLE [dbo].[BillingInvoice]
	CHECK CONSTRAINT [FK__BillingIn__BC_Ke__58DC1D15]

GO
ALTER TABLE [dbo].[BillingInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BIT_C__59D0414E]
	FOREIGN KEY ([BIT_Code]) REFERENCES [dbo].[BillingInvoiceType] ([BIT_Code])
ALTER TABLE [dbo].[BillingInvoice]
	CHECK CONSTRAINT [FK__BillingIn__BIT_C__59D0414E]

GO
ALTER TABLE [dbo].[BillingInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__CL_Co__5AC46587]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[BillingInvoice]
	CHECK CONSTRAINT [FK__BillingIn__CL_Co__5AC46587]

GO
ALTER TABLE [dbo].[BillingInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__CU_Co__5BB889C0]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[BillingInvoice]
	CHECK CONSTRAINT [FK__BillingIn__CU_Co__5BB889C0]

GO
ALTER TABLE [dbo].[BillingInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__PR_Co__5CACADF9]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[BillingInvoice]
	CHECK CONSTRAINT [FK__BillingIn__PR_Co__5CACADF9]

GO
CREATE UNIQUE NONCLUSTERED INDEX [BI_IDX_FormatInvoiceNumber]
	ON [dbo].[BillingInvoice] ([BI_FormatInvoiceNumber])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingInvoice] SET (LOCK_ESCALATION = TABLE)
GO
