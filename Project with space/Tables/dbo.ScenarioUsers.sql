SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScenarioUsers] (
		[SCN_Key]     [int] NOT NULL,
		[US_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Scenario__D3D841A346335CF5]
		PRIMARY KEY
		CLUSTERED
		([SCN_Key], [US_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScenarioUsers]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioU__SCN_K__509BDCCF]
	FOREIGN KEY ([SCN_Key]) REFERENCES [dbo].[Scenario] ([SCN_Key])
ALTER TABLE [dbo].[ScenarioUsers]
	CHECK CONSTRAINT [FK__ScenarioU__SCN_K__509BDCCF]

GO
ALTER TABLE [dbo].[ScenarioUsers]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioU__US_Co__51900108]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[ScenarioUsers]
	CHECK CONSTRAINT [FK__ScenarioU__US_Co__51900108]

GO
ALTER TABLE [dbo].[ScenarioUsers] SET (LOCK_ESCALATION = TABLE)
GO
