SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectPlanControl] (
		[PR_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PPC_Version]             [int] NOT NULL,
		[PPC_Status]              [smallint] NOT NULL,
		[PPC_Desc]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPC_PlanStartDate]       [float] NULL,
		[PPC_CheckedOutBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPC_CheckedOutOn]        [float] NULL,
		[PPC_OverwritenBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPC_OriginalVersion]     [int] NULL,
		[PPC_HasChanged]          [smallint] NULL,
		CONSTRAINT [PK__ProjectP__4185340A520F23F5]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [PPC_Version])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectPlanControl]
	ADD
	CONSTRAINT [DF__ProjectPl__PPC_O__259C7031]
	DEFAULT ((0)) FOR [PPC_OriginalVersion]
GO
ALTER TABLE [dbo].[ProjectPlanControl]
	ADD
	CONSTRAINT [DF__ProjectPl__PPC_H__2690946A]
	DEFAULT ((0)) FOR [PPC_HasChanged]
GO
ALTER TABLE [dbo].[ProjectPlanControl]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectPl__PR_Co__55959C16]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectPlanControl]
	CHECK CONSTRAINT [FK__ProjectPl__PR_Co__55959C16]

GO
ALTER TABLE [dbo].[ProjectPlanControl] SET (LOCK_ESCALATION = TABLE)
GO
