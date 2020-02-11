SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskNoteHeader] (
		[RH_Key]              [int] NOT NULL,
		[RH_Title]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__RiskNote__EC90BDB32F4FF79D]
		PRIMARY KEY
		CLUSTERED
		([RH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskNoteHeader]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskNoteH__RK_Co__47127295]
	FOREIGN KEY ([RK_Code]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[RiskNoteHeader]
	CHECK CONSTRAINT [FK__RiskNoteH__RK_Co__47127295]

GO
ALTER TABLE [dbo].[RiskNoteHeader] SET (LOCK_ESCALATION = TABLE)
GO
