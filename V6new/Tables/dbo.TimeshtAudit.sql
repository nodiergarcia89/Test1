SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeshtAudit] (
		[TSS_Key]                          [int] NOT NULL,
		[TS_Key]                           [int] NOT NULL,
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
		[TS_Notes]                         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
		CONSTRAINT [PK__TimeshtA__6BA1B88136BC0F3B]
		PRIMARY KEY
		CLUSTERED
		([TSS_Key], [TS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TimeshtAudit]
	WITH CHECK
	ADD CONSTRAINT [FK__TimeshtAu__TSS_K__041B80D5]
	FOREIGN KEY ([TSS_Key]) REFERENCES [dbo].[TimesheetSubmissions] ([TSS_Key])
ALTER TABLE [dbo].[TimeshtAudit]
	CHECK CONSTRAINT [FK__TimeshtAu__TSS_K__041B80D5]

GO
ALTER TABLE [dbo].[TimeshtAudit] SET (LOCK_ESCALATION = TABLE)
GO
