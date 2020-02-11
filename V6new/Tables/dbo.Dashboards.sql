SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dashboards] (
		[DSH_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DSH_Name]           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DSH_Page]           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DSH_Order]          [int] NULL,
		[AV_Key]             [int] NULL,
		[US_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DSH_Type]           [int] NULL,
		[DSH_SystemView]     [smallint] NOT NULL,
		[DSH_ViewType]       [int] NULL,
		[PLV_Level]          [int] NULL,
		[DSH_CanEdit]        [smallint] NOT NULL,
		[LG_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DSH_Published]      [smallint] NULL,
		CONSTRAINT [PK__Dashboar__118085CA220B0B18]
		PRIMARY KEY
		CLUSTERED
		([DSH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Dashboards]
	ADD
	CONSTRAINT [DF__Dashboard__DSH_S__23F3538A]
	DEFAULT ((0)) FOR [DSH_SystemView]
GO
ALTER TABLE [dbo].[Dashboards]
	ADD
	CONSTRAINT [DF__Dashboard__DSH_C__24E777C3]
	DEFAULT ((-1)) FOR [DSH_CanEdit]
GO
ALTER TABLE [dbo].[Dashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__Dashboard__AV_Ke__2AE0483B]
	FOREIGN KEY ([AV_Key]) REFERENCES [dbo].[ActionView] ([AV_Key])
ALTER TABLE [dbo].[Dashboards]
	CHECK CONSTRAINT [FK__Dashboard__AV_Ke__2AE0483B]

GO
ALTER TABLE [dbo].[Dashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__Dashboard__LG_Co__2BD46C74]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[Dashboards]
	CHECK CONSTRAINT [FK__Dashboard__LG_Co__2BD46C74]

GO
ALTER TABLE [dbo].[Dashboards] SET (LOCK_ESCALATION = TABLE)
GO
