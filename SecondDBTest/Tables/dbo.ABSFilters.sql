SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ABSFilters] (
		[AF_Key]                [int] NOT NULL,
		[AF_Name]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AF_Desc]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AF_Type]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AF_Title]              [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AF_IncludeDates]       [smallint] NULL,
		[AF_Global]             [smallint] NULL,
		[AV_Key]                [int] NULL,
		[AF_LastEdit]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_CodeLastEdit]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AF_LastEditDate]       [float] NULL,
		[AF_UsageType]          [smallint] NULL,
		[AF_AdvancedFilter]     [nvarchar](750) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AF_EntityKey]          [int] NULL,
		CONSTRAINT [PK__ABSFilte__A62F21A40BC6C43E]
		PRIMARY KEY
		CLUSTERED
		([AF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ABSFilters]
	WITH CHECK
	ADD CONSTRAINT [FK__ABSFilter__US_Co__1431ED0D]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[ABSFilters]
	CHECK CONSTRAINT [FK__ABSFilter__US_Co__1431ED0D]

GO
ALTER TABLE [dbo].[ABSFilters] SET (LOCK_ESCALATION = TABLE)
GO
