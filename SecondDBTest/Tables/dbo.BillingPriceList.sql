SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingPriceList] (
		[BPL_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Active]               [int] NULL,
		[BPL_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BPL_Notes]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BPL_Price]            [float] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BPL_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__BillingP__034F898B607251E5]
		PRIMARY KEY
		CLUSTERED
		([BPL_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingPriceList]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingPr__CU_Co__6DD739FB]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[BillingPriceList]
	CHECK CONSTRAINT [FK__BillingPr__CU_Co__6DD739FB]

GO
ALTER TABLE [dbo].[BillingPriceList] SET (LOCK_ESCALATION = TABLE)
GO
