SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectInfo1] (
		[PR_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_InvAccountNo]                  [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvAddr1]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvAddr2]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvAddr3]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvAddr4]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvAddr5]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvAddr6]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvVAT]                        [real] NULL,
		[PR_InvPaymentTerms]               [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvPassExpenseVATToClient]     [smallint] NULL,
		[PR_InvContactName]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_InvContactPhone]               [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectI__8AF2607F2FBA0BF1]
		PRIMARY KEY
		CLUSTERED
		([PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectInfo1]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectIn__PR_Co__4C0C31DC]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectInfo1]
	CHECK CONSTRAINT [FK__ProjectIn__PR_Co__4C0C31DC]

GO
ALTER TABLE [dbo].[ProjectInfo1] SET (LOCK_ESCALATION = TABLE)
GO
