SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionViewTypes] (
		[AV_Key]           [int] NOT NULL,
		[AT_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AVT_Priority]     [int] NULL,
		CONSTRAINT [PK_ActionViewType]
		PRIMARY KEY
		CLUSTERED
		([AV_Key], [AT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionViewTypes]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__AT_Co__3592E0D8]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ActionViewTypes]
	CHECK CONSTRAINT [FK__ActionVie__AT_Co__3592E0D8]

GO
ALTER TABLE [dbo].[ActionViewTypes]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__AV_Ke__36870511]
	FOREIGN KEY ([AV_Key]) REFERENCES [dbo].[ActionView] ([AV_Key])
ALTER TABLE [dbo].[ActionViewTypes]
	CHECK CONSTRAINT [FK__ActionVie__AV_Ke__36870511]

GO
ALTER TABLE [dbo].[ActionViewTypes] SET (LOCK_ESCALATION = TABLE)
GO
