SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Charge] (
		[CH_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CH_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Status1]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Status2]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Status3]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_RateAmt]          [float] NULL,
		[CH_AllRes]           [smallint] NULL,
		[Active]              [smallint] NULL,
		[CH_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Prefix]           [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_AutoNum]          [int] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Charge__33BBF4F16FB49575]
		PRIMARY KEY
		CLUSTERED
		([CH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Charge]
	WITH CHECK
	ADD CONSTRAINT [FK__Charge__CU_Code__75785BC3]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Charge]
	CHECK CONSTRAINT [FK__Charge__CU_Code__75785BC3]

GO
ALTER TABLE [dbo].[Charge] SET (LOCK_ESCALATION = TABLE)
GO
