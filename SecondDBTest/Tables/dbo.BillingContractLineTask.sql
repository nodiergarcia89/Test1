SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BillingContractLineTask] (
		[BCLT_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[BCL_Key]      [int] NULL,
		[TA_Key]       [int] NULL,
		CONSTRAINT [PK__BillingC__ABDF305245BE5BA9]
		PRIMARY KEY
		CLUSTERED
		([BCLT_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLineTask]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BCL_K__56F3D4A3]
	FOREIGN KEY ([BCL_Key]) REFERENCES [dbo].[BillingContractLine] ([BCL_Key])
ALTER TABLE [dbo].[BillingContractLineTask]
	CHECK CONSTRAINT [FK__BillingCo__BCL_K__56F3D4A3]

GO
ALTER TABLE [dbo].[BillingContractLineTask]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__TA_Ke__57E7F8DC]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[BillingContractLineTask]
	CHECK CONSTRAINT [FK__BillingCo__TA_Ke__57E7F8DC]

GO
ALTER TABLE [dbo].[BillingContractLineTask] SET (LOCK_ESCALATION = TABLE)
GO
