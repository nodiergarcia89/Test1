SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Posts] (
		[PST_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[PST_Status]           [smallint] NOT NULL,
		[PST_Type]             [smallint] NOT NULL,
		[PST_Text]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_Key]               [int] NULL,
		[DV_Key]               [int] NULL,
		[PDL_Key]              [int] NULL,
		[RE_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_CodePostedBy]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PST_PostedDate]       [float] NOT NULL,
		[PST_PostedTime]       [float] NOT NULL,
		[US_CodeLastEdit]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PST_LastEditDate]     [float] NULL,
		[PST_LastEditTime]     [float] NULL,
		CONSTRAINT [PK__Posts__4AA1D26D35A7EF71]
		PRIMARY KEY
		CLUSTERED
		([PST_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Posts]
	WITH CHECK
	ADD CONSTRAINT [FK__Posts__DV_Key__0F03239C]
	FOREIGN KEY ([DV_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[Posts]
	CHECK CONSTRAINT [FK__Posts__DV_Key__0F03239C]

GO
ALTER TABLE [dbo].[Posts]
	WITH CHECK
	ADD CONSTRAINT [FK__Posts__PDL_Key__0FF747D5]
	FOREIGN KEY ([PDL_Key]) REFERENCES [dbo].[ProfileDemandLine] ([PDL_Key])
ALTER TABLE [dbo].[Posts]
	CHECK CONSTRAINT [FK__Posts__PDL_Key__0FF747D5]

GO
ALTER TABLE [dbo].[Posts]
	WITH CHECK
	ADD CONSTRAINT [FK__Posts__PR_Code__10EB6C0E]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Posts]
	CHECK CONSTRAINT [FK__Posts__PR_Code__10EB6C0E]

GO
ALTER TABLE [dbo].[Posts]
	WITH CHECK
	ADD CONSTRAINT [FK__Posts__RE_Code__11DF9047]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Posts]
	CHECK CONSTRAINT [FK__Posts__RE_Code__11DF9047]

GO
ALTER TABLE [dbo].[Posts]
	WITH CHECK
	ADD CONSTRAINT [FK__Posts__RK_Code__12D3B480]
	FOREIGN KEY ([RK_Code]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[Posts]
	CHECK CONSTRAINT [FK__Posts__RK_Code__12D3B480]

GO
ALTER TABLE [dbo].[Posts]
	WITH CHECK
	ADD CONSTRAINT [FK__Posts__TA_Key__13C7D8B9]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[Posts]
	CHECK CONSTRAINT [FK__Posts__TA_Key__13C7D8B9]

GO
ALTER TABLE [dbo].[Posts] SET (LOCK_ESCALATION = TABLE)
GO
