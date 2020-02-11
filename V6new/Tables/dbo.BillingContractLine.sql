SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractLine] (
		[BCL_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[BC_Key]                   [int] NOT NULL,
		[BCL_Desc]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BCL_IsTimeDefault]        [smallint] NULL,
		[BCL_IsExpenseDefault]     [smallint] NULL,
		[NC_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BCL_Type]                 [smallint] NULL,
		[BCL_IsTrackable]          [smallint] NULL,
		[BCL_CycleInterval]        [smallint] NULL,
		[BCL_CycleValue]           [float] NULL,
		[BCL_CycleDate]            [float] NULL,
		[BCL_LastBilledDate]       [float] NULL,
		[BCL_BillingRule]          [smallint] NULL,
		[BCL_CycleUnits]           [float] NULL,
		[DV_Key]                   [int] NULL,
		CONSTRAINT [PK__BillingC__D29EBF792CF2ADDF]
		PRIMARY KEY
		CLUSTERED
		([BCL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLine]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BC_Ke__4C764630]
	FOREIGN KEY ([BC_Key]) REFERENCES [dbo].[BillingContract] ([BC_Key])
ALTER TABLE [dbo].[BillingContractLine]
	CHECK CONSTRAINT [FK__BillingCo__BC_Ke__4C764630]

GO
ALTER TABLE [dbo].[BillingContractLine]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__DV_Ke__4D6A6A69]
	FOREIGN KEY ([DV_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[BillingContractLine]
	CHECK CONSTRAINT [FK__BillingCo__DV_Ke__4D6A6A69]

GO
ALTER TABLE [dbo].[BillingContractLine]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__NC_Co__4E5E8EA2]
	FOREIGN KEY ([NC_Code]) REFERENCES [dbo].[Nominal] ([NC_Code])
ALTER TABLE [dbo].[BillingContractLine]
	CHECK CONSTRAINT [FK__BillingCo__NC_Co__4E5E8EA2]

GO
CREATE NONCLUSTERED INDEX [BCL_ContractKeyIndex]
	ON [dbo].[BillingContractLine] ([BC_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingContractLine] SET (LOCK_ESCALATION = TABLE)
GO
