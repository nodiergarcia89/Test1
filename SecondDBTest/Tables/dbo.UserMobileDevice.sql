SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMobileDevice] (
		[US_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DeviceId]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DevicePlatform]     [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PushToken]          [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PushSettings]       [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AppVersion]         [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LastLoginDate]      [float] NULL,
		CONSTRAINT [PK__UserMobi__64F41B516C23FBB3]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [DeviceId])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserMobileDevice]
	WITH CHECK
	ADD CONSTRAINT [FK__UserMobil__US_Co__135DC465]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserMobileDevice]
	CHECK CONSTRAINT [FK__UserMobil__US_Co__135DC465]

GO
ALTER TABLE [dbo].[UserMobileDevice]
	WITH CHECK
	ADD CONSTRAINT [FK__UserMobil__US_Co__1451E89E]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserMobileDevice]
	CHECK CONSTRAINT [FK__UserMobil__US_Co__1451E89E]

GO
ALTER TABLE [dbo].[UserMobileDevice] SET (LOCK_ESCALATION = TABLE)
GO
