SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskDocuments] (
		[RK_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DH_Key]      [int] NOT NULL,
		CONSTRAINT [PK__RiskDocu__6D5291A40B129727]
		PRIMARY KEY
		CLUSTERED
		([RK_Code], [DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskDocum__DH_Ke__38C4533E]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[RiskDocuments]
	CHECK CONSTRAINT [FK__RiskDocum__DH_Ke__38C4533E]

GO
ALTER TABLE [dbo].[RiskDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskDocum__RK_Co__39B87777]
	FOREIGN KEY ([RK_Code]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[RiskDocuments]
	CHECK CONSTRAINT [FK__RiskDocum__RK_Co__39B87777]

GO
ALTER TABLE [dbo].[RiskDocuments] SET (LOCK_ESCALATION = TABLE)
GO
