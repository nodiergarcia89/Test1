SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityGroupLogin] (
		[SG_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SG_ViewTSRes]              [smallint] NULL,
		[SG_ViewTSPrj]              [smallint] NULL,
		[SG_MainTSRes]              [smallint] NULL,
		[SG_MainTSPrj]              [smallint] NULL,
		[SG_ApprTSRes]              [smallint] NULL,
		[SG_ApprTSPrj]              [smallint] NULL,
		[SG_ViewExpRes]             [smallint] NULL,
		[SG_ViewExpPrj]             [smallint] NULL,
		[SG_MainExpRes]             [smallint] NULL,
		[SG_MainExpPrj]             [smallint] NULL,
		[SG_ApprExpRes]             [smallint] NULL,
		[SG_ApprExpPrj]             [smallint] NULL,
		[SG_PayExpRes]              [smallint] NULL,
		[SG_ViewBudPrj]             [smallint] NULL,
		[SG_MainBudPrj]             [smallint] NULL,
		[SG_ViewSchRes]             [smallint] NULL,
		[SG_ViewSchPrj]             [smallint] NULL,
		[SG_MainSchRes]             [smallint] NULL,
		[SG_MainSchPrj]             [smallint] NULL,
		[SG_PropSkillRes]           [smallint] NULL,
		[SG_ApprSkillRes]           [smallint] NULL,
		[SG_ViewSetCli]             [smallint] NULL,
		[SG_MainSetCli]             [smallint] NULL,
		[SG_ViewActRes]             [smallint] NULL,
		[SG_MainActRes]             [smallint] NULL,
		[SG_ViewCtrRes]             [smallint] NULL,
		[SG_ViewRiskRes]            [smallint] NULL,
		[SG_ViewRiskPrj]            [smallint] NULL,
		[SG_MainRiskRes]            [smallint] NULL,
		[SG_MainRiskPrj]            [smallint] NULL,
		[SG_ViewProfPrj]            [smallint] NULL,
		[SG_MainProfPrj]            [smallint] NULL,
		[SG_MainDirectProfRes]      [smallint] NULL,
		[SG_MainDirectProfPrj]      [smallint] NULL,
		[SG_ViewSetRes]             [smallint] NULL,
		[SG_ViewSetPrj]             [smallint] NULL,
		[SG_MainSetRes]             [smallint] NULL,
		[SG_MainSetPrj]             [smallint] NULL,
		[SG_ClientDefault]          [smallint] NULL,
		[SG_ContractorDefault]      [smallint] NULL,
		[SG_ViewSupplyRes]          [smallint] NULL,
		[SG_ViewSupplyPrj]          [smallint] NULL,
		[SG_ViewDeliverableRes]     [smallint] NULL,
		[SG_ViewDeliverablePrj]     [smallint] NULL,
		[SG_MainDeliverableRes]     [smallint] NULL,
		[SG_MainDeliverablePrj]     [smallint] NULL,
		[SG_ViewDeploymentRes]      [smallint] NULL,
		[SG_MainDeploymentRes]      [smallint] NULL,
		[SG_AccessCBPrj]            [smallint] NULL,
		[SG_ViewActPrj]             [smallint] NULL,
		[SG_MainActPrj]             [smallint] NULL,
		CONSTRAINT [PK__Security__E573D8E364B7E415]
		PRIMARY KEY
		CLUSTERED
		([SG_Code], [US_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SecurityGroupLogin]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__SG_Co__5A254709]
	FOREIGN KEY ([SG_Code]) REFERENCES [dbo].[SecurityGroup] ([SG_Code])
ALTER TABLE [dbo].[SecurityGroupLogin]
	CHECK CONSTRAINT [FK__SecurityG__SG_Co__5A254709]

GO
ALTER TABLE [dbo].[SecurityGroupLogin]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__US_Co__5B196B42]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[SecurityGroupLogin]
	CHECK CONSTRAINT [FK__SecurityG__US_Co__5B196B42]

GO
ALTER TABLE [dbo].[SecurityGroupLogin] SET (LOCK_ESCALATION = TABLE)
GO
