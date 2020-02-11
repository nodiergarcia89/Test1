SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocaleDayDefaults] (
		[LH_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LDD_DayOfWeek]           [int] NOT NULL,
		[LDD_FTE]                 [float] NOT NULL,
		[LDD_LocaleDayLength]     [float] NULL,
		CONSTRAINT [PK__LocaleDa__74437EC548EFCE0F]
		PRIMARY KEY
		CLUSTERED
		([LH_Code], [LDD_DayOfWeek])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LocaleDayDefaults]
	WITH CHECK
	ADD CONSTRAINT [FK__LocaleDay__LH_Co__6BB9E75F]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[LocaleDayDefaults]
	CHECK CONSTRAINT [FK__LocaleDay__LH_Co__6BB9E75F]

GO
ALTER TABLE [dbo].[LocaleDayDefaults] SET (LOCK_ESCALATION = TABLE)
GO
