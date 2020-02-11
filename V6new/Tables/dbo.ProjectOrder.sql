SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectOrder] (
		[PR_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_Level10Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level9Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level8Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level7Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level6Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level5Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level4Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level3Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level2Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PO_Level1Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectO__8AF2607F4E3E9311]
		PRIMARY KEY
		CLUSTERED
		([PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectOrder]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectOr__PR_Co__54A177DD]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectOrder]
	CHECK CONSTRAINT [FK__ProjectOr__PR_Co__54A177DD]

GO
ALTER TABLE [dbo].[ProjectOrder] SET (LOCK_ESCALATION = TABLE)
GO
