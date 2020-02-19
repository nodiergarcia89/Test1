SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLevel] (
		[PLV_Level]            [int] NOT NULL,
		[PLV_Abbreviation]     [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLV_DescSingle]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLV_DescPlural]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLV_EffortUnits]      [int] NOT NULL,
		[PLV_CostUnits]        [int] NOT NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLV_LastEditDate]     [float] NOT NULL,
		[PLV_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ProjectL__D43C4639338A9CD5]
		PRIMARY KEY
		CLUSTERED
		([PLV_Level])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLevel] SET (LOCK_ESCALATION = TABLE)
GO
