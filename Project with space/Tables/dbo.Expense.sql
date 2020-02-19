SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Expense] (
		[EX_Key]                [int] IDENTITY(1, 1) NOT NULL,
		[EX_Date]               [float] NOT NULL,
		[RE_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TY_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CI_Key]                [int] NULL,
		[EX_Accrued]            [smallint] NULL,
		[EX_Units]              [float] NULL,
		[CU_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EX_LocalAmt]           [float] NULL,
		[EX_Amt]                [float] NULL,
		[EX_VAT]                [real] NULL,
		[EX_LocalNet]           [float] NULL,
		[EX_Net]                [float] NULL,
		[EX_Chargeable]         [smallint] NULL,
		[EX_LocalChargeAmt]     [float] NULL,
		[EX_ChargeAmt]          [float] NULL,
		[EX_ChargeVAT]          [real] NULL,
		[EX_LocalChargeNet]     [float] NULL,
		[EX_ChargeNet]          [float] NULL,
		[CM_Key]                [int] NULL,
		[EX_Paid]               [smallint] NULL,
		[IH_Key]                [int] NULL,
		[EX_Notes]              [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EX_Approved]           [smallint] NULL,
		[EX_ApprovalDate]       [float] NULL,
		[EX_ApprovalRef]        [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EX_Null]               [bit] NULL,
		[CP_Key]                [int] NULL,
		[CC_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EX_LastEditDate]       [float] NULL,
		[EX_LastEdit]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_Key]                [int] NULL,
		[BCD_Key]               [int] NULL,
		[BIL_Key]               [int] NULL,
		[EX_WrittenOff]         [int] NULL,
		[EX_Invoiced]           [int] NULL,
		[DH_KeyReceipt]         [int] NULL,
		[CU_CodePayment]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ER_RatePayment]        [float] NULL,
		[EX_PaymentAmt]         [float] NULL,
		[EX_Reimbursable]       [smallint] NULL,
		CONSTRAINT [PK__Expense__905691220AF29B96]
		PRIMARY KEY
		CLUSTERED
		([EX_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__BCD_Key__56BECA79]
	FOREIGN KEY ([BCD_Key]) REFERENCES [dbo].[BillingContractLineDetails] ([BCD_Key])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__BCD_Key__56BECA79]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__BI_Key__57B2EEB2]
	FOREIGN KEY ([BI_Key]) REFERENCES [dbo].[BillingInvoice] ([BI_Key])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__BI_Key__57B2EEB2]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__BIL_Key__58A712EB]
	FOREIGN KEY ([BIL_Key]) REFERENCES [dbo].[BillingInvoiceLine] ([BIL_Key])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__BIL_Key__58A712EB]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__CC_Code__599B3724]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__CC_Code__599B3724]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__CM_Key__5A8F5B5D]
	FOREIGN KEY ([CM_Key]) REFERENCES [dbo].[Claims] ([CM_Key])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__CM_Key__5A8F5B5D]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__CP_Key__5B837F96]
	FOREIGN KEY ([CP_Key]) REFERENCES [dbo].[ClosePeriod] ([CP_Key])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__CP_Key__5B837F96]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__CU_Code__5C77A3CF]
	FOREIGN KEY ([CU_CodePayment]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__CU_Code__5C77A3CF]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__CU_Code__5D6BC808]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__CU_Code__5D6BC808]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__DE_Code__5E5FEC41]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__DE_Code__5E5FEC41]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__EC_Code__5F54107A]
	FOREIGN KEY ([EC_Code]) REFERENCES [dbo].[ExpCategory] ([EC_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__EC_Code__5F54107A]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__PR_Code__604834B3]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__PR_Code__604834B3]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__RE_Code__613C58EC]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__RE_Code__613C58EC]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK__Expense__TY_Code__62307D25]
	FOREIGN KEY ([TY_Code]) REFERENCES [dbo].[Type] ([TY_Code])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK__Expense__TY_Code__62307D25]

GO
ALTER TABLE [dbo].[Expense]
	WITH CHECK
	ADD CONSTRAINT [FK_ExpenseDocumentHeaderReceipt]
	FOREIGN KEY ([DH_KeyReceipt]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[Expense]
	CHECK CONSTRAINT [FK_ExpenseDocumentHeaderReceipt]

GO
CREATE NONCLUSTERED INDEX [EX_DateIndex]
	ON [dbo].[Expense] ([EX_Date])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EX_DateProjectIndex]
	ON [dbo].[Expense] ([EX_Date], [PR_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EX_DateResourceIndex]
	ON [dbo].[Expense] ([EX_Date], [RE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EX_ProjectDateIndex]
	ON [dbo].[Expense] ([PR_Code], [EX_Date])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EX_ResourceDateIndex]
	ON [dbo].[Expense] ([RE_Code], [EX_Date])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Expense] SET (LOCK_ESCALATION = TABLE)
GO
