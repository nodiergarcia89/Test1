SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResAct] (
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AC_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ResAct__2B090B011B7E091A]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [AC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResAct]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAct__AC_Code__0544AF38]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[ResAct]
	CHECK CONSTRAINT [FK__ResAct__AC_Code__0544AF38]

GO
ALTER TABLE [dbo].[ResAct]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAct__RE_Code__0638D371]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResAct]
	CHECK CONSTRAINT [FK__ResAct__RE_Code__0638D371]

GO
ALTER TABLE [dbo].[ResAct] SET (LOCK_ESCALATION = TABLE)
GO
