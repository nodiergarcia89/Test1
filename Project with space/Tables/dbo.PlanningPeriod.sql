SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PlanningPeriod] (
		[PP_StartDate]     [float] NOT NULL,
		[PP_EndDate]       [float] NOT NULL,
		[PP_Month]         [float] NOT NULL,
		[PP_WeekStart]     [float] NOT NULL,
		CONSTRAINT [PK__Planning__9DC3E3012942188C]
		PRIMARY KEY
		CLUSTERED
		([PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PlanningPeriod]
	ADD
	CONSTRAINT [DF__PlanningP__PP_We__2B2A60FE]
	DEFAULT ((0)) FOR [PP_WeekStart]
GO
ALTER TABLE [dbo].[PlanningPeriod] SET (LOCK_ESCALATION = TABLE)
GO
