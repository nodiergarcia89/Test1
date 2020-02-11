SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskAttachments] (
		[RK_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[RiskAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskAttac__RK_Co__34F3C25A]
	FOREIGN KEY ([RK_Code]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[RiskAttachments]
	CHECK CONSTRAINT [FK__RiskAttac__RK_Co__34F3C25A]

GO
CREATE NONCLUSTERED INDEX [RiskAttachments_Index]
	ON [dbo].[RiskAttachments] ([RK_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RiskAttachments] SET (LOCK_ESCALATION = TABLE)
GO
