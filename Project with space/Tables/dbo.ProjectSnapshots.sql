SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectSnapshots] (
		[PSS_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[PSS_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PSS_Type]             [smallint] NULL,
		[PR_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_CodeLastEdit]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PSS_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__ProjectS__2DE4D1E53A653155]
		PRIMARY KEY
		CLUSTERED
		([PSS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectSnapshots]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PR_Co__401B5C43]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectSnapshots]
	CHECK CONSTRAINT [FK__ProjectSn__PR_Co__401B5C43]

GO
ALTER TABLE [dbo].[ProjectSnapshots] SET (LOCK_ESCALATION = TABLE)
GO
