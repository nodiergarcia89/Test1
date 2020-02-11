SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WidgetConfig] (
		[WDC_Key]          [bigint] IDENTITY(1, 1) NOT NULL,
		[WDC_WidgetId]     [uniqueidentifier] NOT NULL,
		[US_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WDC_Config]       [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DSH_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WI_WidgetId]      [uniqueidentifier] NULL,
		[LG_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__WidgetCo__9D42F12F0B9CA70C]
		PRIMARY KEY
		CLUSTERED
		([WDC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WidgetConfig]
	WITH CHECK
	ADD CONSTRAINT [FK__WidgetCon__DSH_C__1FC39B4A]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[WidgetConfig]
	CHECK CONSTRAINT [FK__WidgetCon__DSH_C__1FC39B4A]

GO
ALTER TABLE [dbo].[WidgetConfig]
	WITH CHECK
	ADD CONSTRAINT [FK__WidgetCon__US_Co__20B7BF83]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[WidgetConfig]
	CHECK CONSTRAINT [FK__WidgetCon__US_Co__20B7BF83]

GO
ALTER TABLE [dbo].[WidgetConfig] SET (LOCK_ESCALATION = TABLE)
GO
