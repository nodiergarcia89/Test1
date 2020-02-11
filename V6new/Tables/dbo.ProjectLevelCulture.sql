SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLevelCulture] (
		[PLV_Level]             [int] NOT NULL,
		[CLC_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLVC_Abbreviation]     [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLVC_DescSingle]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLVC_DescPlural]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectL__FF5A7B23375B2DB9]
		PRIMARY KEY
		CLUSTERED
		([PLV_Level], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLevelCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLe__CLC_C__4D005615]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[ProjectLevelCulture]
	CHECK CONSTRAINT [FK__ProjectLe__CLC_C__4D005615]

GO
ALTER TABLE [dbo].[ProjectLevelCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLe__PLV_L__4DF47A4E]
	FOREIGN KEY ([PLV_Level]) REFERENCES [dbo].[ProjectLevel] ([PLV_Level])
ALTER TABLE [dbo].[ProjectLevelCulture]
	CHECK CONSTRAINT [FK__ProjectLe__PLV_L__4DF47A4E]

GO
ALTER TABLE [dbo].[ProjectLevelCulture] SET (LOCK_ESCALATION = TABLE)
GO
