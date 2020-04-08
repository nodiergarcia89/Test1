SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Timesht] (
		[TS_Key]                           [int] IDENTITY(1, 1) NOT NULL,
		[TS_Date]                          [float] NOT NULL,
		[RE_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AC_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CI_Key]                           [int] NULL,
		[TS_Accrued]                       [smallint] NULL,
		[TS_CostRateAmt]                   [float] NULL,
		[CH_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TS_ChargeRateAmt]                 [float] NULL,
		[TS_LocalCostRateAmt]              [float] NULL,
		[TS_LocalCostCurrencySymbol]       [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TS_LocalChargeRateAmt]            [float] NULL,
		[TS_LocalChargeCurrencySymbol]     [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TS_StartTime]                     [float] NULL,
		[TS_FinishTime]                    [float] NULL,
		[TS_Hours]                         [float] NULL,
		[TS_Chargeable]                    [smallint] NULL,
		[TS_Overtime]                      [smallint] NULL,
		[IH_Key]                           [int] NULL,
		[TA_Key]                           [int] NULL,
		[AS_Key]                           [int] NULL,
		[MS_Key]                           [int] NULL,
		[TS_Notes]                         [nvarchar](1500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TS_Approved]                      [smallint] NULL,
		[TS_ApprovalDate]                  [float] NULL,
		[TS_ApprovalRef]                   [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CP_Key]                           [int] NULL,
		[CC_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TS_DirectEntry]                   [smallint] NULL,
		[TS_Null]                          [bit] NULL,
		[US_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TS_LastEditDate]                  [float] NULL,
		[TS_LastEdit]                      [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BI_Key]                           [int] NULL,
		[BCD_Key]                          [int] NULL,
		[TS_WrittenOff]                    [int] NULL,
		[TS_Invoiced]                      [int] NULL,
		[BIL_Key]                          [int] NULL,
		[TSS_Key]                          [int] NULL,
		[TS_DisapprovedReason]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BPL_Code]                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TS_BillingPrice]                  [float] NULL,
		CONSTRAINT [PK__Timesht__71342B2432EB7E57]
		PRIMARY KEY
		CLUSTERED
		([TS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__RE_Code__004AEFF1]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__RE_Code__004AEFF1]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__RE_Code__013F142A]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__RE_Code__013F142A]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__TA_Key__02333863]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__TA_Key__02333863]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__TSS_Key__03275C9C]
	FOREIGN KEY ([TSS_Key]) REFERENCES [dbo].[TimesheetSubmissions] ([TSS_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__TSS_Key__03275C9C]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__AC_Code__74D93D45]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__AC_Code__74D93D45]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__AS_Key__75CD617E]
	FOREIGN KEY ([AS_Key]) REFERENCES [dbo].[Assignment] ([AS_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__AS_Key__75CD617E]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__BCD_Key__76C185B7]
	FOREIGN KEY ([BCD_Key]) REFERENCES [dbo].[BillingContractLineDetails] ([BCD_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__BCD_Key__76C185B7]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__BI_Key__77B5A9F0]
	FOREIGN KEY ([BI_Key]) REFERENCES [dbo].[BillingInvoice] ([BI_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__BI_Key__77B5A9F0]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__BIL_Key__78A9CE29]
	FOREIGN KEY ([BIL_Key]) REFERENCES [dbo].[BillingInvoiceLine] ([BIL_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__BIL_Key__78A9CE29]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__BPL_Cod__799DF262]
	FOREIGN KEY ([BPL_Code]) REFERENCES [dbo].[BillingPriceList] ([BPL_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__BPL_Cod__799DF262]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__CC_Code__7A92169B]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__CC_Code__7A92169B]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__CH_Code__7B863AD4]
	FOREIGN KEY ([CH_Code]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__CH_Code__7B863AD4]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__CO_Code__7C7A5F0D]
	FOREIGN KEY ([CO_Code]) REFERENCES [dbo].[Cost] ([CO_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__CO_Code__7C7A5F0D]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__CP_Key__7D6E8346]
	FOREIGN KEY ([CP_Key]) REFERENCES [dbo].[ClosePeriod] ([CP_Key])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__CP_Key__7D6E8346]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__DE_Code__7E62A77F]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__DE_Code__7E62A77F]

GO
ALTER TABLE [dbo].[Timesht]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesht__PR_Code__7F56CBB8]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Timesht]
	CHECK CONSTRAINT [FK__Timesht__PR_Code__7F56CBB8]

GO
CREATE NONCLUSTERED INDEX [TS_ASKeyIndex]
	ON [dbo].[Timesht] ([AS_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TS_CPKeyProjIndex]
	ON [dbo].[Timesht] ([CP_Key], [PR_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TS_DateProjectIndex]
	ON [dbo].[Timesht] ([TS_Date], [PR_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TS_ProjActIndex]
	ON [dbo].[Timesht] ([PR_Code], [AC_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TS_ResourceDateIndex]
	ON [dbo].[Timesht] ([RE_Code], [TS_Date])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TS_TaskAssignmentIndex]
	ON [dbo].[Timesht] ([TA_Key], [AS_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TS_TSSKeyIndex]
	ON [dbo].[Timesht] ([TSS_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Timesht] SET (LOCK_ESCALATION = TABLE)
GO
