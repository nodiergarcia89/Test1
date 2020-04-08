SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FilterView] (
		[FV_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[FV_Desc]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FV_EntityType]           [int] NOT NULL,
		[FV_EntityPermission]     [smallint] NULL,
		[FV_AllowUserFilters]     [smallint] NULL,
		[FV_XmlDefinition]        [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FV_LastEdit]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FV_LastEditDate]         [float] NULL,
		CONSTRAINT [PK__FilterVi__586575DD1A34DF26]
		PRIMARY KEY
		CLUSTERED
		([FV_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[FilterView] SET (LOCK_ESCALATION = TABLE)
GO
