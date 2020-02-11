SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeRows] (
		[TR_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[RE_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AC_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_Key]              [int] NULL,
		[AS_Key]              [int] NULL,
		[CO_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TR_Overtime]         [smallint] NULL,
		[TR_Chargeable]       [smallint] NULL,
		[TR_CustomKey1]       [int] NULL,
		[TR_CustomKey2]       [int] NULL,
		[TR_CustomValue1]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TR_CustomValue2]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__TimeRows__63ED98492B4A5C8F]
		PRIMARY KEY
		CLUSTERED
		([TR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TimeRows]
	WITH CHECK
	ADD CONSTRAINT [FK__TimeRows__PR_Cod__71FCD09A]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[TimeRows]
	CHECK CONSTRAINT [FK__TimeRows__PR_Cod__71FCD09A]

GO
ALTER TABLE [dbo].[TimeRows]
	WITH CHECK
	ADD CONSTRAINT [FK__TimeRows__RE_Cod__72F0F4D3]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[TimeRows]
	CHECK CONSTRAINT [FK__TimeRows__RE_Cod__72F0F4D3]

GO
ALTER TABLE [dbo].[TimeRows] SET (LOCK_ESCALATION = TABLE)
GO
