SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPageState] (
		[UPS_Key]            [int] IDENTITY(1, 1) NOT NULL,
		[UPS_SessionID]      [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPS_PageKey]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPS_ItemKey]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_UserID]          [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPS_BinaryData]     [varbinary](max) NULL,
		[UPS_XmlData]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UPS_Timestamp]      [timestamp] NULL,
		CONSTRAINT [PK__UserPage__839C7B6DE66DCED9]
		PRIMARY KEY
		CLUSTERED
		([UPS_Key])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [UPS_UserIDIndex]
	ON [dbo].[UserPageState] ([US_UserID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UPS_SessionIDPageKeyIndex]
	ON [dbo].[UserPageState] ([UPS_SessionID], [UPS_PageKey])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserPageState] SET (LOCK_ESCALATION = TABLE)
GO
