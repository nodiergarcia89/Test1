SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingContractLineActivity] (
		[BCLA_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[BCL_Key]      [int] NULL,
		[AC_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__BillingC__E57D56AA30C33EC3]
		PRIMARY KEY
		CLUSTERED
		([BCLA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingContractLineActivity]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__AC_Co__4F52B2DB]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[BillingContractLineActivity]
	CHECK CONSTRAINT [FK__BillingCo__AC_Co__4F52B2DB]

GO
ALTER TABLE [dbo].[BillingContractLineActivity]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingCo__BCL_K__5046D714]
	FOREIGN KEY ([BCL_Key]) REFERENCES [dbo].[BillingContractLine] ([BCL_Key])
ALTER TABLE [dbo].[BillingContractLineActivity]
	CHECK CONSTRAINT [FK__BillingCo__BCL_K__5046D714]

GO
ALTER TABLE [dbo].[BillingContractLineActivity] SET (LOCK_ESCALATION = TABLE)
GO
