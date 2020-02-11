SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLifecycleStageCondition] (
		[PLFSC_Key]            [int] IDENTITY(1, 1) NOT NULL,
		[PLFS_Key]             [int] NOT NULL,
		[PLFSC_Desc]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFSC_FilterType]     [smallint] NOT NULL,
		[PLFSC_Result]         [smallint] NOT NULL,
		[AV_Key]               [int] NULL,
		[AF_Key]               [int] NULL,
		CONSTRAINT [PK__ProjectL__86BB6385469D7149]
		PRIMARY KEY
		CLUSTERED
		([PLFSC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLifecycleStageCondition]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLi__AF_Ke__50D0E6F9]
	FOREIGN KEY ([AF_Key]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ProjectLifecycleStageCondition]
	CHECK CONSTRAINT [FK__ProjectLi__AF_Ke__50D0E6F9]

GO
ALTER TABLE [dbo].[ProjectLifecycleStageCondition]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLi__AV_Ke__51C50B32]
	FOREIGN KEY ([AV_Key]) REFERENCES [dbo].[ActionView] ([AV_Key])
ALTER TABLE [dbo].[ProjectLifecycleStageCondition]
	CHECK CONSTRAINT [FK__ProjectLi__AV_Ke__51C50B32]

GO
ALTER TABLE [dbo].[ProjectLifecycleStageCondition]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLi__PLFS___52B92F6B]
	FOREIGN KEY ([PLFS_Key]) REFERENCES [dbo].[ProjectLifecycleStage] ([PLFS_Key])
ALTER TABLE [dbo].[ProjectLifecycleStageCondition]
	CHECK CONSTRAINT [FK__ProjectLi__PLFS___52B92F6B]

GO
ALTER TABLE [dbo].[ProjectLifecycleStageCondition] SET (LOCK_ESCALATION = TABLE)
GO
