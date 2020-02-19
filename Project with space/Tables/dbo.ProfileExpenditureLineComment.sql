SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileExpenditureLineComment] (
		[PEC_Key]               [int] IDENTITY(1, 1) NOT NULL,
		[PEL_Key]               [int] NOT NULL,
		[PEC_PlainText]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PEC_FormattedText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PEC_LastEditDate]      [float] NOT NULL,
		CONSTRAINT [PK__ProfileE__A83EA85905C3D225]
		PRIMARY KEY
		CLUSTERED
		([PEC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileExpenditureLineComment]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__PEL_K__3CC9EE4C]
	FOREIGN KEY ([PEL_Key]) REFERENCES [dbo].[ProfileExpenditureLine] ([PEL_Key])
ALTER TABLE [dbo].[ProfileExpenditureLineComment]
	CHECK CONSTRAINT [FK__ProfileEx__PEL_K__3CC9EE4C]

GO
CREATE NONCLUSTERED INDEX [PEC_ExpLineIndex]
	ON [dbo].[ProfileExpenditureLineComment] ([PEL_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProfileExpenditureLineComment] SET (LOCK_ESCALATION = TABLE)
GO
