SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ScenarioRelations] (
		[MasterSCN]     [int] NOT NULL,
		[SubSCN]        [int] NOT NULL,
		CONSTRAINT [PK__Scenario__3603D56D4262CC11]
		PRIMARY KEY
		CLUSTERED
		([MasterSCN], [SubSCN])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScenarioRelations]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioR__Maste__4EB3945D]
	FOREIGN KEY ([MasterSCN]) REFERENCES [dbo].[Scenario] ([SCN_Key])
ALTER TABLE [dbo].[ScenarioRelations]
	CHECK CONSTRAINT [FK__ScenarioR__Maste__4EB3945D]

GO
ALTER TABLE [dbo].[ScenarioRelations]
	WITH CHECK
	ADD CONSTRAINT [FK__ScenarioR__SubSC__4FA7B896]
	FOREIGN KEY ([SubSCN]) REFERENCES [dbo].[Scenario] ([SCN_Key])
ALTER TABLE [dbo].[ScenarioRelations]
	CHECK CONSTRAINT [FK__ScenarioR__SubSC__4FA7B896]

GO
ALTER TABLE [dbo].[ScenarioRelations] SET (LOCK_ESCALATION = TABLE)
GO
