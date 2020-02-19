SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroupActionViews] (
		[LG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AV_Key]      [int] NOT NULL,
		CONSTRAINT [PK_LoginGroupActionViews]
		PRIMARY KEY
		CLUSTERED
		([LG_Code], [AV_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroupActionViews]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__AV_Ke__772B9A0B]
	FOREIGN KEY ([AV_Key]) REFERENCES [dbo].[ActionView] ([AV_Key])
ALTER TABLE [dbo].[LoginGroupActionViews]
	CHECK CONSTRAINT [FK__LoginGrou__AV_Ke__772B9A0B]

GO
ALTER TABLE [dbo].[LoginGroupActionViews]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__LG_Co__781FBE44]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[LoginGroupActionViews]
	CHECK CONSTRAINT [FK__LoginGrou__LG_Co__781FBE44]

GO
ALTER TABLE [dbo].[LoginGroupActionViews] SET (LOCK_ESCALATION = TABLE)
GO
