SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost] (
		[CO_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CO_Desc]                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_RateAmt]               [float] NULL,
		[CO_Status1]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_Status2]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_Status3]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_AllRes]                [smallint] NULL,
		[Active]                   [smallint] NULL,
		[CO_LastEdit]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_Prefix]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_AutoNum]               [int] NULL,
		[US_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_LastEditDate]          [float] NULL,
		[CO_AppliesToStandard]     [smallint] NULL,
		[CO_AppliesToOvertime]     [smallint] NULL,
		CONSTRAINT [PK__Cost__F1AAA7D361316BF4]
		PRIMARY KEY
		CLUSTERED
		([CO_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Cost]
	WITH CHECK
	ADD CONSTRAINT [FK__Cost__CU_Code__1D864D1D]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Cost]
	CHECK CONSTRAINT [FK__Cost__CU_Code__1D864D1D]

GO
ALTER TABLE [dbo].[Cost] SET (LOCK_ESCALATION = TABLE)
GO
