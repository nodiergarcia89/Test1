SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BenefitType] (
		[BET_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BET_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BET_Type]             [smallint] NULL,
		[BET_Active]           [smallint] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BET_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__BenefitT__6EEB10FC151B244E]
		PRIMARY KEY
		CLUSTERED
		([BET_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BenefitType] SET (LOCK_ESCALATION = TABLE)
GO
