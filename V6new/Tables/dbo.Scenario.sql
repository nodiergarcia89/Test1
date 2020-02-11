SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Scenario] (
		[SCN_Key]                [int] IDENTITY(1, 1) NOT NULL,
		[SCN_Desc]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SCN_PlainTextNotes]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SCN_FormattedNotes]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SCN_IsBaseline]         [smallint] NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SCN_LastEditDate]       [float] NOT NULL,
		[US_CodeOwner]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SCN_Mode]               [smallint] NULL,
		[SCN_Level]              [smallint] NULL,
		CONSTRAINT [PK__Scenario__C5DEE1353AC1AA49]
		PRIMARY KEY
		CLUSTERED
		([SCN_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Scenario]
	ADD
	CONSTRAINT [DF__Scenario__SCN_Mo__11558062]
	DEFAULT ((0)) FOR [SCN_Mode]
GO
ALTER TABLE [dbo].[Scenario]
	ADD
	CONSTRAINT [DF__Scenario__SCN_Le__1249A49B]
	DEFAULT ((0)) FOR [SCN_Level]
GO
ALTER TABLE [dbo].[Scenario]
	WITH CHECK
	ADD CONSTRAINT [FK__Scenario__PR_Cod__49EEDF40]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Scenario]
	CHECK CONSTRAINT [FK__Scenario__PR_Cod__49EEDF40]

GO
ALTER TABLE [dbo].[Scenario]
	WITH CHECK
	ADD CONSTRAINT [FK__Scenario__US_Cod__4AE30379]
	FOREIGN KEY ([US_CodeOwner]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[Scenario]
	CHECK CONSTRAINT [FK__Scenario__US_Cod__4AE30379]

GO
ALTER TABLE [dbo].[Scenario] SET (LOCK_ESCALATION = TABLE)
GO
