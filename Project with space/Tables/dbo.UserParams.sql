SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserParams] (
		[UP_Code]       [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UP_Index]      [int] NOT NULL,
		[UP_Value]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UP_Number]     [float] NULL,
		CONSTRAINT [PK__UserPara__D872488570E8B0D0]
		PRIMARY KEY
		CLUSTERED
		([UP_Code], [US_Code], [UP_Index])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserParams]
	WITH CHECK
	ADD CONSTRAINT [FK__UserParam__US_Co__15460CD7]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserParams]
	CHECK CONSTRAINT [FK__UserParam__US_Co__15460CD7]

GO
ALTER TABLE [dbo].[UserParams] SET (LOCK_ESCALATION = TABLE)
GO
