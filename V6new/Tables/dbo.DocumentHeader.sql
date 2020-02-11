SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentHeader] (
		[DH_Key]                [int] NOT NULL,
		[DH_Id]                 [int] NOT NULL,
		[DH_Version]            [int] NOT NULL,
		[DH_VersionMinor]       [int] NULL,
		[DH_Filename]           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_Desc]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_ContentType]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_ActualSize]         [bigint] NULL,
		[DH_ReferenceCount]     [int] NULL,
		[DH_CheckedOutBy]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_CheckedOutDate]     [float] NULL,
		[DH_CheckedInBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_CheckedInDate]      [float] NULL,
		[DH_LastEditUser]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_LastEditDate]       [float] NULL,
		CONSTRAINT [PK__Document__CCCBB9B37F80E8EA]
		PRIMARY KEY
		CLUSTERED
		([DH_Key])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [DH_CleanUpIndex]
	ON [dbo].[DocumentHeader] ([DH_CheckedInBy], [DH_ReferenceCount])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DH_IdVersionIndex]
	ON [dbo].[DocumentHeader] ([DH_Id], [DH_Version])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentHeader] SET (LOCK_ESCALATION = TABLE)
GO
