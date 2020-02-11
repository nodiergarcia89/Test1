SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroupProjectLevelLbl] (
		[LG_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLV_Level]             [int] NOT NULL,
		[LGPL_Abbreviation]     [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LGPL_DescSingle]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LGPL_DescPlural]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__LoginGro__0C4E05A501342732]
		PRIMARY KEY
		CLUSTERED
		([LG_Code], [PLV_Level])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroupProjectLevelLbl]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__LG_Co__7ECCBBD3]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[LoginGroupProjectLevelLbl]
	CHECK CONSTRAINT [FK__LoginGrou__LG_Co__7ECCBBD3]

GO
ALTER TABLE [dbo].[LoginGroupProjectLevelLbl]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__PLV_L__7FC0E00C]
	FOREIGN KEY ([PLV_Level]) REFERENCES [dbo].[ProjectLevel] ([PLV_Level])
ALTER TABLE [dbo].[LoginGroupProjectLevelLbl]
	CHECK CONSTRAINT [FK__LoginGrou__PLV_L__7FC0E00C]

GO
ALTER TABLE [dbo].[LoginGroupProjectLevelLbl] SET (LOCK_ESCALATION = TABLE)
GO
