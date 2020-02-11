SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLifecycleStage] (
		[PLFS_Key]                                 [int] IDENTITY(1, 1) NOT NULL,
		[PLF_Code]                                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFS_Desc]                                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFS_Ordinal]                             [int] NULL,
		[PLFS_SetActiveFlagTo]                     [smallint] NULL,
		[PLFS_SetAvailableForTETrackingFlagTo]     [smallint] NULL,
		[PLFS_IsChargeable]                        [smallint] NULL,
		CONSTRAINT [PK__ProjectL__9D5FDC4242CCE065]
		PRIMARY KEY
		CLUSTERED
		([PLFS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLifecycleStage]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLi__PLF_C__4FDCC2C0]
	FOREIGN KEY ([PLF_Code]) REFERENCES [dbo].[ProjectLifecycle] ([PLF_Code])
ALTER TABLE [dbo].[ProjectLifecycleStage]
	CHECK CONSTRAINT [FK__ProjectLi__PLF_C__4FDCC2C0]

GO
ALTER TABLE [dbo].[ProjectLifecycleStage] SET (LOCK_ESCALATION = TABLE)
GO
