SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WidgetParams] (
		[WDP_Key]          [bigint] IDENTITY(1, 1) NOT NULL,
		[WDP_WidgetId]     [uniqueidentifier] NOT NULL,
		[US_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DSH_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WDP_Params]       [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__WidgetPa__76C3D7180F6D37F0]
		PRIMARY KEY
		CLUSTERED
		([WDP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WidgetParams]
	WITH CHECK
	ADD CONSTRAINT [FK__WidgetPar__US_Co__21ABE3BC]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[WidgetParams]
	CHECK CONSTRAINT [FK__WidgetPar__US_Co__21ABE3BC]

GO
ALTER TABLE [dbo].[WidgetParams] SET (LOCK_ESCALATION = TABLE)
GO
