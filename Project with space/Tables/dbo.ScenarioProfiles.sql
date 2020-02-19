SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScenarioProfiles] (
		[SCN_Key]     [int] NOT NULL,
		[PR_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRF_Key]     [int] NULL,
		CONSTRAINT [PK__Scenario__2D71C7323E923B2D]
		PRIMARY KEY
		CLUSTERED
		([SCN_Key], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScenarioProfiles]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioP__PR_Co__4BD727B2]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ScenarioProfiles]
	CHECK CONSTRAINT [FK__ScenarioP__PR_Co__4BD727B2]

GO
ALTER TABLE [dbo].[ScenarioProfiles]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioP__PRF_K__4CCB4BEB]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ScenarioProfiles]
	CHECK CONSTRAINT [FK__ScenarioP__PRF_K__4CCB4BEB]

GO
ALTER TABLE [dbo].[ScenarioProfiles]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioP__SCN_K__4DBF7024]
	FOREIGN KEY ([SCN_Key]) REFERENCES [dbo].[Scenario] ([SCN_Key])
ALTER TABLE [dbo].[ScenarioProfiles]
	CHECK CONSTRAINT [FK__ScenarioP__SCN_K__4DBF7024]

GO
ALTER TABLE [dbo].[ScenarioProfiles] SET (LOCK_ESCALATION = TABLE)
GO
