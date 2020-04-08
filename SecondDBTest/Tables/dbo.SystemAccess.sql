SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemAccess] (
		[SYP_Product]     [int] NOT NULL,
		[US_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[SystemAccess]
	WITH CHECK
	ADD CONSTRAINT [FK__SystemAcc__US_Co__62BA8D0A]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[SystemAccess]
	CHECK CONSTRAINT [FK__SystemAcc__US_Co__62BA8D0A]

GO
ALTER TABLE [dbo].[SystemAccess] SET (LOCK_ESCALATION = TABLE)
GO
