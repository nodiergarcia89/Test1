SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserIDs] (
		[UID_UserID]                    [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UID_Password]                  [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UID_PasswordChangedDate]       [float] NULL,
		[UID_UseTrusted]                [smallint] NULL,
		[UID_SiteID]                    [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UID_LoginGUID]                 [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UID_LoginDateTime]             [float] NULL,
		[UID_Active]                    [smallint] NULL,
		[UID_RememberMe]                [smallint] NULL,
		[UID_RememberMeToken]           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UID_UsingRememberedLogon]      [smallint] NULL,
		[UID_FederationID]              [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UID_BypassWhitelisting]        [int] NULL,
		[UID_ExemptFromEnforcedSSO]     [smallint] NULL,
		CONSTRAINT [PK__UserIDs__86AD417B6482D9EB]
		PRIMARY KEY
		CLUSTERED
		([UID_UserID])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserIDs] SET (LOCK_ESCALATION = TABLE)
GO
