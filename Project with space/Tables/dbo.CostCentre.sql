SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CostCentre] (
		[CC_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Desc]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Status1]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Status2]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Status3]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Active]              [smallint] NOT NULL,
		[CC_Notes]               [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_EditOn]              [float] NULL,
		[CC_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_LastEditDate]        [float] NOT NULL,
		[CC_LastEdit]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__CostCent__D8CC4F1B6501FCD8]
		PRIMARY KEY
		CLUSTERED
		([CC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CostCentre] SET (LOCK_ESCALATION = TABLE)
GO
