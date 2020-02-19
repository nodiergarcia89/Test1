SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLifecycle] (
		[PLF_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLF_Desc]                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLF_Active]                [smallint] NULL,
		[PLF_ForceSequential]       [smallint] NULL,
		[PLF_EnforceValidation]     [smallint] NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLF_LastEditDate]          [float] NULL,
		CONSTRAINT [PK__ProjectL__C09728C53B2BBE9D]
		PRIMARY KEY
		CLUSTERED
		([PLF_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLifecycle] SET (LOCK_ESCALATION = TABLE)
GO
