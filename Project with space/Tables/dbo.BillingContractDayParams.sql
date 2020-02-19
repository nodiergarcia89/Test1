SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BillingContractDayParams] (
		[BCP_Key]            [int] IDENTITY(1, 1) NOT NULL,
		[BC_Key]             [int] NOT NULL,
		[BCP_LowerBound]     [float] NULL,
		[BCP_UpperBound]     [float] NULL,
		[BCP_DayValue]       [float] NULL,
		CONSTRAINT [PK__BillingC__228290BD2180FB33]
		PRIMARY KEY
		CLUSTERED
		([BCP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractDayParams]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BC_Ke__4A8DFDBE]
	FOREIGN KEY ([BC_Key]) REFERENCES [dbo].[BillingContract] ([BC_Key])
ALTER TABLE [dbo].[BillingContractDayParams]
	CHECK CONSTRAINT [FK__BillingCo__BC_Ke__4A8DFDBE]

GO
CREATE NONCLUSTERED INDEX [BCP_ContractKeyIndex]
	ON [dbo].[BillingContractDayParams] ([BC_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingContractDayParams] SET (LOCK_ESCALATION = TABLE)
GO
