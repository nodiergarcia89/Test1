SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Jobs] (
		[JO_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[JO_Name]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[JO_CommandType]     [smallint] NULL,
		[JO_CommandText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Jobs__79606EF6414EAC47]
		PRIMARY KEY
		CLUSTERED
		([JO_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Jobs] SET (LOCK_ESCALATION = TABLE)
GO
