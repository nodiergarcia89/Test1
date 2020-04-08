SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrjCharge] (
		[PR_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CH_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PC_RateAmt]     [float] NULL,
		CONSTRAINT [PK__PrjCharg__89C9DF303D491139]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [CH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PrjCharge]
	WITH CHECK
	ADD CONSTRAINT [FK__PrjCharge__CH_Co__16A44564]
	FOREIGN KEY ([CH_Code]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[PrjCharge]
	CHECK CONSTRAINT [FK__PrjCharge__CH_Co__16A44564]

GO
ALTER TABLE [dbo].[PrjCharge]
	WITH CHECK
	ADD CONSTRAINT [FK__PrjCharge__PR_Co__1798699D]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[PrjCharge]
	CHECK CONSTRAINT [FK__PrjCharge__PR_Co__1798699D]

GO
CREATE NONCLUSTERED INDEX [PC_ChargePrjIndex]
	ON [dbo].[PrjCharge] ([CH_Code], [PR_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PrjCharge] SET (LOCK_ESCALATION = TABLE)
GO
