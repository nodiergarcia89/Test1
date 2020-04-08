SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ApplicationLink] (
		[AL_Key]                                     [int] IDENTITY(1, 1) NOT NULL,
		[AL_ProviderCode]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_BaseUrl]                                 [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_CertificateText]                         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_CertificatePassword]                     [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthConsumerKey]                        [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthRequestTokenUrl]                    [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthUserAuthorisationUrl]               [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthAccessTokenUrl]                     [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthAccessToken]                        [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthAccessTokenSecret]                  [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_OAuthAccessTokenDate]                    [float] NULL,
		[AL_TaskIDCustomFieldKey]                    [int] NULL,
		[AL_ProjectIDCustomFieldKey]                 [int] NULL,
		[AL_ResourceIDCustomFieldKey]                [int] NULL,
		[AL_JIRASprintCustomFieldID]                 [int] NULL,
		[AL_JIRAProjectLastSynchCustomFieldID]       [int] NULL,
		[AL_TaskSprintIDCustomFieldKey]              [int] NULL,
		[US_CodeLastEdit]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AL_LastEditDate]                            [float] NULL,
		[AL_JIRATaskLastSynchTimeCustomFieldKey]     [int] NULL,
		[AL_JIRASynchType]                           [int] NOT NULL,
		[AL_JIRAIssueTypeCustomFieldKey]             [int] NOT NULL,
		[AL_JIRAStoryTypeID]                         [int] NULL,
		CONSTRAINT [PK__Applicat__D6E3F08F6E01572D]
		PRIMARY KEY
		CLUSTERED
		([AL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ApplicationLink]
	ADD
	CONSTRAINT [DF__Applicati__AL_JI__6FE99F9F]
	DEFAULT ((0)) FOR [AL_JIRASynchType]
GO
ALTER TABLE [dbo].[ApplicationLink]
	ADD
	CONSTRAINT [DF__Applicati__AL_JI__70DDC3D8]
	DEFAULT ((0)) FOR [AL_JIRAIssueTypeCustomFieldKey]
GO
ALTER TABLE [dbo].[ApplicationLink] SET (LOCK_ESCALATION = TABLE)
GO
