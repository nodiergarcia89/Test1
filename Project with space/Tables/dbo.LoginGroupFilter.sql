SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroupFilter] (
		[LG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AF_Key]      [int] NOT NULL,
		CONSTRAINT [PK__LoginGro__DB6F33DC7993056A]
		PRIMARY KEY
		CLUSTERED
		([LG_Code], [AF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroupFilter]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__AF_Ke__7AFC2AEF]
	FOREIGN KEY ([AF_Key]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[LoginGroupFilter]
	CHECK CONSTRAINT [FK__LoginGrou__AF_Ke__7AFC2AEF]

GO
ALTER TABLE [dbo].[LoginGroupFilter]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__LG_Co__7BF04F28]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[LoginGroupFilter]
	CHECK CONSTRAINT [FK__LoginGrou__LG_Co__7BF04F28]

GO
ALTER TABLE [dbo].[LoginGroupFilter] SET (LOCK_ESCALATION = TABLE)
GO
