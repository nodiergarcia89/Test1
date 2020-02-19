SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractLineArchive] (
		[BCA_Key]               [int] NOT NULL,
		[BC_Key]                [int] NOT NULL,
		[BCL_Key]               [int] NOT NULL,
		[BCL_CycleInterval]     [smallint] NULL,
		[BCL_CycleDate]         [float] NULL,
		[BCL_CycleUnits]        [float] NULL,
		[BCL_CycleValue]        [float] NULL,
		[BCL_Desc]              [nvarchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [UQ__BillingC__7249221837703C52]
		UNIQUE
		NONCLUSTERED
		([BCA_Key], [BCL_Key])
		ON [PRIMARY],
		CONSTRAINT [PK__BillingC__091709FB3493CFA7]
		PRIMARY KEY
		CLUSTERED
		([BCA_Key], [BC_Key], [BCL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLineArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BCA_K__513AFB4D]
	FOREIGN KEY ([BCA_Key]) REFERENCES [dbo].[BillingContractArchive] ([BCA_Key])
ALTER TABLE [dbo].[BillingContractLineArchive]
	CHECK CONSTRAINT [FK__BillingCo__BCA_K__513AFB4D]

GO
ALTER TABLE [dbo].[BillingContractLineArchive] SET (LOCK_ESCALATION = TABLE)
GO
