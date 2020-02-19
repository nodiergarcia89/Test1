SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContract] (
		[BC_Key]                           [int] IDENTITY(1, 1) NOT NULL,
		[BC_Desc]                          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_Reference]                     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_Status]                        [smallint] NOT NULL,
		[PR_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BC_DefaultLineType]               [smallint] NULL,
		[BC_ManagerRECode]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_DefaultPONumber]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_DayLength]                     [float] NULL,
		[CU_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_FixedExchangeRate]             [float] NULL,
		[BC_VATNumber]                     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAccountNo]                  [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAddr1]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAddr2]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAddr3]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAddr4]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAddr5]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvAddr6]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvContactName]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvContactPhoneNo]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_DefaultCycleInterval]          [smallint] NULL,
		[BC_LastEdit]                      [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_EditBy]                        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_EditOn]                        [float] NULL,
		[BC_EditOverwriteBy]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_Notes]                         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_InvVATRate]                    [float] NULL,
		[BC_ExchangeRateOption]            [smallint] NULL,
		[BC_CappedDay]                     [float] NULL,
		[BC_ChrgOutputVAT]                 [smallint] NULL,
		[BC_PaymentTerms]                  [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_LastEditDate]                  [float] NULL,
		[BC_DefInvTimePrintFormat]         [smallint] NULL,
		[BC_DefInvExpPrintFormat]          [smallint] NULL,
		[BC_UseDefaultInvoiceTemplate]     [smallint] NOT NULL,
		[IT_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_Date]                          [float] NULL,
		[BC_BillingTimeType]               [smallint] NULL,
		[BC_RoutingType]                   [smallint] NULL,
		[BC_UsePriceList]                  [smallint] NULL,
		CONSTRAINT [PK__BillingC__EA55EAA918EBB532]
		PRIMARY KEY
		CLUSTERED
		([BC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContract]
	ADD
	CONSTRAINT [DF__BillingCo__BC_Us__1AD3FDA4]
	DEFAULT ((-1)) FOR [BC_UseDefaultInvoiceTemplate]
GO
ALTER TABLE [dbo].[BillingContract]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BC_Ma__45C948A1]
	FOREIGN KEY ([BC_ManagerRECode]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[BillingContract]
	CHECK CONSTRAINT [FK__BillingCo__BC_Ma__45C948A1]

GO
ALTER TABLE [dbo].[BillingContract]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__CU_Co__46BD6CDA]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[BillingContract]
	CHECK CONSTRAINT [FK__BillingCo__CU_Co__46BD6CDA]

GO
ALTER TABLE [dbo].[BillingContract]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__IT_Co__47B19113]
	FOREIGN KEY ([IT_Code]) REFERENCES [dbo].[InvoiceTemplate] ([IT_Code])
ALTER TABLE [dbo].[BillingContract]
	CHECK CONSTRAINT [FK__BillingCo__IT_Co__47B19113]

GO
ALTER TABLE [dbo].[BillingContract]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__PR_Co__48A5B54C]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[BillingContract]
	CHECK CONSTRAINT [FK__BillingCo__PR_Co__48A5B54C]

GO
CREATE NONCLUSTERED INDEX [BC_ProjectCodeIndex]
	ON [dbo].[BillingContract] ([PR_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BC_ReferenceIndex]
	ON [dbo].[BillingContract] ([BC_Reference])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingContract] SET (LOCK_ESCALATION = TABLE)
GO
