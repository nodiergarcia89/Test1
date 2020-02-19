SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssignmentPlan] (
		[AS_Key]          [int] NOT NULL,
		[AP_Date]         [int] NOT NULL,
		[AP_Work]         [float] NULL,
		[AP_LastEdit]     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Assignme__7F7C874308B54D69]
		PRIMARY KEY
		CLUSTERED
		([AS_Key], [AP_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[AssignmentPlan]
	WITH CHECK
	ADD CONSTRAINT [FK__Assignmen__AS_Ke__41F8B7BD]
	FOREIGN KEY ([AS_Key]) REFERENCES [dbo].[Assignment] ([AS_Key])
ALTER TABLE [dbo].[AssignmentPlan]
	CHECK CONSTRAINT [FK__Assignmen__AS_Ke__41F8B7BD]

GO
ALTER TABLE [dbo].[AssignmentPlan] SET (LOCK_ESCALATION = TABLE)
GO
