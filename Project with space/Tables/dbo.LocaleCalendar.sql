SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocaleCalendar] (
		[LH_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LC_Date]             [float] NOT NULL,
		[LC_DayOfWeek]        [int] NOT NULL,
		[LC_IsOverridden]     [int] NOT NULL,
		[LC_FTE]              [float] NOT NULL,
		CONSTRAINT [PK__LocaleCa__633BF4A2451F3D2B]
		PRIMARY KEY
		CLUSTERED
		([LH_Code], [LC_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LocaleCalendar]
	WITH CHECK
	ADD CONSTRAINT [FK__LocaleCal__LH_Co__6AC5C326]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[LocaleCalendar]
	CHECK CONSTRAINT [FK__LocaleCal__LH_Co__6AC5C326]

GO
ALTER TABLE [dbo].[LocaleCalendar] SET (LOCK_ESCALATION = TABLE)
GO
