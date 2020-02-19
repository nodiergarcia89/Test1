SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskItemType] (
		[RIT_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RIT_Desc]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RIT_DefaultCustomFields]     [int] NULL,
		[RIT_Active]                  [smallint] NULL,
		[RIT_LastEdit]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RIT_DefaultItem]             [smallint] NULL,
		[US_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RIT_LastEditDate]            [float] NULL,
		CONSTRAINT [PK__RiskItem__2D27A10026BAB19C]
		PRIMARY KEY
		CLUSTERED
		([RIT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskItemType] SET (LOCK_ESCALATION = TABLE)
GO
