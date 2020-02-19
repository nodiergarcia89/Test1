SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BillingContractDocuments] (
		[BC_Key]     [int] NOT NULL,
		[DH_Key]     [int] NOT NULL,
		CONSTRAINT [PK__BillingC__C699513229221CFB]
		PRIMARY KEY
		CLUSTERED
		([BC_Key], [DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractDocuments] SET (LOCK_ESCALATION = TABLE)
GO
