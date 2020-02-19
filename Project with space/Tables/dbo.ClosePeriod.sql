SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClosePeriod] (
		[CP_Key]                    [int] NOT NULL,
		[CP_FromDate]               [float] NULL,
		[CP_ToDate]                 [float] NULL,
		[CP_Include]                [int] NULL,
		[CP_Notes]                  [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CP_TimesheetCount]         [int] NULL,
		[CP_ExpenseCount]           [int] NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CP_LastEditDate]           [float] NULL,
		[CP_LastEdit]               [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PP_Month]                  [float] NULL,
		[CP_TimesheetsExported]     [smallint] NULL,
		[CP_ExpensesExported]       [smallint] NULL,
		[AF_KeyTimesheet]           [int] NULL,
		[AF_KeyExpense]             [int] NULL,
		CONSTRAINT [PK__ClosePer__B5A6174B2AD55B43]
		PRIMARY KEY
		CLUSTERED
		([CP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClosePeriod]
	WITH CHECK
	ADD CONSTRAINT [FK__ClosePeri__AF_Ke__0B679CE2]
	FOREIGN KEY ([AF_KeyTimesheet]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ClosePeriod]
	CHECK CONSTRAINT [FK__ClosePeri__AF_Ke__0B679CE2]

GO
ALTER TABLE [dbo].[ClosePeriod]
	WITH CHECK
	ADD CONSTRAINT [FK__ClosePeri__AF_Ke__0C5BC11B]
	FOREIGN KEY ([AF_KeyExpense]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ClosePeriod]
	CHECK CONSTRAINT [FK__ClosePeri__AF_Ke__0C5BC11B]

GO
ALTER TABLE [dbo].[ClosePeriod] SET (LOCK_ESCALATION = TABLE)
GO
