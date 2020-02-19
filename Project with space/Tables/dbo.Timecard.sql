SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Timecard] (
		[RE_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TC_Date]       [float] NOT NULL,
		[TC_Fields]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Timecard__1C8C04022779CBAB]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [TC_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Timecard]
	WITH CHECK
	ADD CONSTRAINT [FK__Timecard__RE_Cod__7108AC61]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Timecard]
	CHECK CONSTRAINT [FK__Timecard__RE_Cod__7108AC61]

GO
ALTER TABLE [dbo].[Timecard] SET (LOCK_ESCALATION = TABLE)
GO
