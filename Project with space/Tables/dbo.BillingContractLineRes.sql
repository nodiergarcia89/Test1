SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractLineRes] (
		[BCLR_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[BCL_Key]      [int] NOT NULL,
		[RE_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [UNIQUE_BCLKey_RECode]
		UNIQUE
		NONCLUSTERED
		([BCL_Key], [RE_Code])
		ON [PRIMARY],
		CONSTRAINT [BCLR_PKey]
		PRIMARY KEY
		CLUSTERED
		([BCLR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLineRes]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BCL_K__550B8C31]
	FOREIGN KEY ([BCL_Key]) REFERENCES [dbo].[BillingContractLine] ([BCL_Key])
ALTER TABLE [dbo].[BillingContractLineRes]
	CHECK CONSTRAINT [FK__BillingCo__BCL_K__550B8C31]

GO
ALTER TABLE [dbo].[BillingContractLineRes]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__RE_Co__55FFB06A]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[BillingContractLineRes]
	CHECK CONSTRAINT [FK__BillingCo__RE_Co__55FFB06A]

GO
ALTER TABLE [dbo].[BillingContractLineRes] SET (LOCK_ESCALATION = TABLE)
GO
