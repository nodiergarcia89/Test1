SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingPriceListArchive] (
		[BPLA_Key]          [int] IDENTITY(1, 1) NOT NULL,
		[BPLA_DateTime]     [float] NULL,
		[BPL_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BPLA_NewPrice]     [float] NULL,
		[BPLA_OldPrice]     [float] NULL,
		[US_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__BillingP__D123FEA26442E2C9]
		PRIMARY KEY
		CLUSTERED
		([BPLA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingPriceListArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingPr__BPL_C__6ECB5E34]
	FOREIGN KEY ([BPL_Code]) REFERENCES [dbo].[BillingPriceList] ([BPL_Code])
ALTER TABLE [dbo].[BillingPriceListArchive]
	CHECK CONSTRAINT [FK__BillingPr__BPL_C__6ECB5E34]

GO
ALTER TABLE [dbo].[BillingPriceListArchive] SET (LOCK_ESCALATION = TABLE)
GO
