SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroup] (
		[LG_Code]                                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LG_Desc]                                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LG_ClientAccess]                           [int] NULL,
		[LG_ClientGroupAccess]                      [int] NULL,
		[LG_ActionAccess]                           [int] NULL,
		[LG_Active]                                 [smallint] NULL,
		[AV_KeyDefault]                             [int] NULL,
		[LG_LastEdit]                               [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LG_LastEditDate]                           [float] NULL,
		[LG_OptInEmailNotifications]                [smallint] NULL,
		[LG_ResourcingMode]                         [int] NULL,
		[LG_ProjectViewPermission]                  [int] NULL,
		[LG_DemandSource]                           [int] NULL,
		[AV_KeyDocuments]                           [int] NULL,
		[LG_ProjectDocumentsTab]                    [smallint] NULL,
		[LG_ShowMyWork]                             [smallint] NULL,
		[LG_ShowMyProjects]                         [smallint] NULL,
		[LG_ShowResourcing]                         [smallint] NULL,
		[LG_ShowInsights]                           [smallint] NULL,
		[LG_NavigatorCustomField]                   [int] NULL,
		[LG_IncludeTemplateProjectsInNavigator]     [smallint] NULL,
		[LG_ProjectDocumentTabAboveLevelOne]        [smallint] NULL,
		[LG_LogoFileName]                           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__LoginGro__810DC1C66F1576F7]
		PRIMARY KEY
		CLUSTERED
		([LG_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroup]
	ADD
	CONSTRAINT [DF__LoginGrou__LG_Pr__60BD35FF]
	DEFAULT ((0)) FOR [LG_ProjectDocumentTabAboveLevelOne]
GO
ALTER TABLE [dbo].[LoginGroup]
	ADD
	CONSTRAINT [DF__LoginGrou__LG_De__70FDBF69]
	DEFAULT ((0)) FOR [LG_DemandSource]
GO
ALTER TABLE [dbo].[LoginGroup] SET (LOCK_ESCALATION = TABLE)
GO
