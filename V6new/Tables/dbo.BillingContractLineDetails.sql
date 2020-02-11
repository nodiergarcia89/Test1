SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractLineDetails] (
		[BCD_Key]                [int] IDENTITY(1, 1) NOT NULL,
		[BCL_Key]                [int] NOT NULL,
		[BCD_PONumber]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BCD_Units]              [float] NULL,
		[BCD_PerUnitRate]        [float] NULL,
		[BCD_StartDate]          [float] NULL,
		[BCD_ExpiryDate]         [float] NULL,
		[BCD_DefaultTime]        [smallint] NULL,
		[BCD_DefaultExpense]     [smallint] NULL,
		[BCD_Notes]              [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BPL_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__BillingC__4122DCFD3B40CD36]
		PRIMARY KEY
		CLUSTERED
		([BCD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLineDetails]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BCL_K__522F1F86]
	FOREIGN KEY ([BCL_Key]) REFERENCES [dbo].[BillingContractLine] ([BCL_Key])
ALTER TABLE [dbo].[BillingContractLineDetails]
	CHECK CONSTRAINT [FK__BillingCo__BCL_K__522F1F86]

GO
ALTER TABLE [dbo].[BillingContractLineDetails]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BPL_C__532343BF]
	FOREIGN KEY ([BPL_Code]) REFERENCES [dbo].[BillingPriceList] ([BPL_Code])
ALTER TABLE [dbo].[BillingContractLineDetails]
	CHECK CONSTRAINT [FK__BillingCo__BPL_C__532343BF]

GO
CREATE NONCLUSTERED INDEX [BCD_ContractLineKeyIndex]
	ON [dbo].[BillingContractLineDetails] ([BCL_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BCD_PONumberIndex]
	ON [dbo].[BillingContractLineDetails] ([BCD_PONumber])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingContractLineDetails] SET (LOCK_ESCALATION = TABLE)
GO
