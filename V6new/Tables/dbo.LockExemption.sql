SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LockExemption] (
		[LE_Type]     [int] NOT NULL,
		[US_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__LockExem__DD6B57B35832119F]
		PRIMARY KEY
		CLUSTERED
		([LE_Type], [US_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LockExemption]
	WITH CHECK
	ADD CONSTRAINT [FK__LockExemp__US_Co__6E96540A]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LockExemption]
	CHECK CONSTRAINT [FK__LockExemp__US_Co__6E96540A]

GO
ALTER TABLE [dbo].[LockExemption] SET (LOCK_ESCALATION = TABLE)
GO
