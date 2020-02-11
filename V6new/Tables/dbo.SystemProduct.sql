SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemProduct] (
		[SYP_Product]                [int] NOT NULL,
		[SYP_Title]                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SYP_UserLicence]            [smallint] NULL,
		[SYP_Licence]                [int] NULL,
		[SYP_LicenceCheck]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SYP_LicenceExpiry]          [float] NULL,
		[SYP_LicenceExpiryCheck]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SYP_Limit]                  [int] NULL,
		[SYP_LimitCheck]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__SystemPr__80BACA8E08012052]
		PRIMARY KEY
		CLUSTERED
		([SYP_Product])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SystemProduct] SET (LOCK_ESCALATION = TABLE)
GO
