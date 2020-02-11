SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskText] (
		[RK_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RK_PlainTextDetails]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_FormattedDetails]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_PlainTextContingency]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_FormattedContingency]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__RiskText__419E2A3F36F11965]
		PRIMARY KEY
		CLUSTERED
		([RK_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskText]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskText__RK_Cod__48FABB07]
	FOREIGN KEY ([RK_Code]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[RiskText]
	CHECK CONSTRAINT [FK__RiskText__RK_Cod__48FABB07]

GO
CREATE FULLTEXT INDEX ON [dbo].[RiskText]
	([RK_PlainTextDetails] LANGUAGE 1033, [RK_PlainTextContingency] LANGUAGE 1033)
	KEY INDEX [PK__RiskText__419E2A3F36F11965]
	ON (FILEGROUP [PRIMARY], [CAT_Risk])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[RiskText] SET (LOCK_ESCALATION = TABLE)
GO
