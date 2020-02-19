SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionTypeConfig] (
		[AT_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ATC_ConfigXML]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ActionTy__B90A6A133E52440B]
		PRIMARY KEY
		CLUSTERED
		([AT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionTypeConfig]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__AT_Co__2A212E2C]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ActionTypeConfig]
	CHECK CONSTRAINT [FK__ActionTyp__AT_Co__2A212E2C]

GO
ALTER TABLE [dbo].[ActionTypeConfig] SET (LOCK_ESCALATION = TABLE)
GO
