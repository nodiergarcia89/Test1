SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TitleValues] (
		[TV_Value]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__TitleVal__96A2DC225540965B]
		PRIMARY KEY
		CLUSTERED
		([TV_Value])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TitleValues] SET (LOCK_ESCALATION = TABLE)
GO
