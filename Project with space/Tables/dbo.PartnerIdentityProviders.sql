SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PartnerIdentityProviders] (
		[PIP_ProviderID]                       [int] IDENTITY(1, 1) NOT NULL,
		[PIP_SiteID]                           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_Issuer]                           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_ServiceProviderName]              [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_SingleSignOnServiceUrl]           [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_SingleSignOnServiceBinding]       [smallint] NULL,
		[PIP_SignAuthnRequest]                 [smallint] NULL,
		[PIP_ForceAuthn]                       [smallint] NULL,
		[PIP_WantResponseSigned]               [smallint] NULL,
		[PIP_AssertionCertificateType]         [smallint] NULL,
		[PIP_IdentityType]                     [smallint] NULL,
		[PIP_IdentityLocation]                 [smallint] NULL,
		[PIP_AttributeName]                    [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_Certificate]                      [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_ServiceProviderCertificateID]     [int] NULL,
		[PIP_MetadataURL]                      [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PIP_IsMobile]                         [smallint] NULL,
		CONSTRAINT [PK__PartnerI__5B9C27B1257187A8]
		PRIMARY KEY
		CLUSTERED
		([PIP_ProviderID])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PartnerIdentityProviders] SET (LOCK_ESCALATION = TABLE)
GO
