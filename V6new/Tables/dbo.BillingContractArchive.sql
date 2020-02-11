SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractArchive] (
		[BCA_Key]                   [int] IDENTITY(1, 1) NOT NULL,
		[BC_Key]                    [int] NOT NULL,
		[BCA_Archived]              [float] NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_CappedDay]              [float] NULL,
		[BC_FixedExchangeRate]      [float] NULL,
		[BC_ExchangeRateOption]     [smallint] NULL,
		[BCA_Changes]               [smallint] NULL,
		[CU_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BC_BillingTimeType]        [smallint] NULL,
		CONSTRAINT [PK__BillingC__FF60C9EE1DB06A4F]
		PRIMARY KEY
		CLUSTERED
		([BCA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BC_Ke__4999D985]
	FOREIGN KEY ([BC_Key]) REFERENCES [dbo].[BillingContract] ([BC_Key])
ALTER TABLE [dbo].[BillingContractArchive]
	CHECK CONSTRAINT [FK__BillingCo__BC_Ke__4999D985]

GO
CREATE NONCLUSTERED INDEX [BCA_ContractKeyIndex]
	ON [dbo].[BillingContractArchive] ([BC_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingContractArchive] SET (LOCK_ESCALATION = TABLE)
GO
