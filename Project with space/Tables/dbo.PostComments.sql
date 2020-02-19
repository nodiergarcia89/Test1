SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PostComments] (
		[PCO_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[PST_Key]              [int] NOT NULL,
		[PCO_Text]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_CodePostedBy]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PCO_PostedDate]       [float] NOT NULL,
		[PCO_PostedTime]       [float] NOT NULL,
		[US_CodeLastEdit]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PCO_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__PostComm__CD984BF52E06CDA9]
		PRIMARY KEY
		CLUSTERED
		([PCO_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PostComments]
	WITH CHECK
	ADD CONSTRAINT [FK__PostComme__PST_K__0B3292B8]
	FOREIGN KEY ([PST_Key]) REFERENCES [dbo].[Posts] ([PST_Key])
ALTER TABLE [dbo].[PostComments]
	CHECK CONSTRAINT [FK__PostComme__PST_K__0B3292B8]

GO
ALTER TABLE [dbo].[PostComments]
	WITH CHECK
	ADD CONSTRAINT [FK__PostComme__RE_Co__0C26B6F1]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[PostComments]
	CHECK CONSTRAINT [FK__PostComme__RE_Co__0C26B6F1]

GO
ALTER TABLE [dbo].[PostComments] SET (LOCK_ESCALATION = TABLE)
GO
