SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BillingContractDayParamsArchive] (
		[BCA_Key]            [int] NOT NULL,
		[BC_Key]             [int] NOT NULL,
		[BCP_Key]            [int] NOT NULL,
		[BCP_LowerBound]     [float] NULL,
		[BCP_UpperBound]     [float] NULL,
		[BCP_DayValue]       [float] NULL,
		CONSTRAINT [PK__BillingC__CDE715D425518C17]
		PRIMARY KEY
		CLUSTERED
		([BCA_Key], [BC_Key], [BCP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractDayParamsArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BCA_K__4B8221F7]
	FOREIGN KEY ([BCA_Key]) REFERENCES [dbo].[BillingContractArchive] ([BCA_Key])
ALTER TABLE [dbo].[BillingContractDayParamsArchive]
	CHECK CONSTRAINT [FK__BillingCo__BCA_K__4B8221F7]

GO
ALTER TABLE [dbo].[BillingContractDayParamsArchive] SET (LOCK_ESCALATION = TABLE)
GO
