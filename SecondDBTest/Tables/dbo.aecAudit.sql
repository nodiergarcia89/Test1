SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[aecAudit] (
		[AD_ID]         [int] NOT NULL,
		[AD_Date]       [float] NOT NULL,
		[US_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AD_Desc]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AD_Change]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__aecAudit__75B2F28E66603565]
		PRIMARY KEY
		CLUSTERED
		([AD_ID], [AD_Date], [US_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[aecAudit] SET (LOCK_ESCALATION = TABLE)
GO
