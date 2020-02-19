SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractLineDetailsArchive] (
		[BCA_Key]             [int] NOT NULL,
		[BCL_Key]             [int] NOT NULL,
		[BCD_Key]             [int] NOT NULL,
		[BCD_PONumber]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BCD_Units]           [float] NULL,
		[BCD_PerUnitRate]     [float] NULL,
		[BCD_StartDate]       [float] NULL,
		[BCD_ExpiryDate]      [float] NULL,
		[BPL_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__BillingC__8E0800C53F115E1A]
		PRIMARY KEY
		CLUSTERED
		([BCA_Key], [BCL_Key], [BCD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLineDetailsArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingContractL__541767F8]
	FOREIGN KEY ([BCA_Key], [BCL_Key]) REFERENCES [dbo].[BillingContractLineArchive] ([BCA_Key], [BCL_Key])
ALTER TABLE [dbo].[BillingContractLineDetailsArchive]
	CHECK CONSTRAINT [FK__BillingContractL__541767F8]

GO
ALTER TABLE [dbo].[BillingContractLineDetailsArchive] SET (LOCK_ESCALATION = TABLE)
GO
