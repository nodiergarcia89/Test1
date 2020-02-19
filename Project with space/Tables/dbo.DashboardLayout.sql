SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DashboardLayout] (
		[DSL_Key]        [bigint] IDENTITY(1, 1) NOT NULL,
		[DSH_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DSL_Layout]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Dashboar__C06C54981E3A7A34]
		PRIMARY KEY
		CLUSTERED
		([DSL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DashboardLayout]
	WITH CHECK
	ADD CONSTRAINT [FK__Dashboard__DSH_C__28F7FFC9]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[DashboardLayout]
	CHECK CONSTRAINT [FK__Dashboard__DSH_C__28F7FFC9]

GO
ALTER TABLE [dbo].[DashboardLayout]
	WITH CHECK
	ADD CONSTRAINT [FK__Dashboard__US_Co__29EC2402]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[DashboardLayout]
	CHECK CONSTRAINT [FK__Dashboard__US_Co__29EC2402]

GO
ALTER TABLE [dbo].[DashboardLayout] SET (LOCK_ESCALATION = TABLE)
GO
