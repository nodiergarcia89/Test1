SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DepartmentHeadcountDetail] (
		[DHL_Key]                  [int] NOT NULL,
		[PP_StartDate]             [float] NOT NULL,
		[PP_EndDate]               [float] NOT NULL,
		[DHD_Days]                 [float] NULL,
		[DHD_FTE]                  [float] NULL,
		[DHD_LocalDayCostRate]     [float] NULL,
		[DHD_LocalCost]            [float] NULL,
		[DHD_SystemCost]           [float] NULL,
		CONSTRAINT [PK__Departme__AB06452B595B4002]
		PRIMARY KEY
		CLUSTERED
		([DHL_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentHeadcountDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DHL_K__41C3AD93]
	FOREIGN KEY ([DHL_Key]) REFERENCES [dbo].[DepartmentHeadcountLine] ([DHL_Key])
ALTER TABLE [dbo].[DepartmentHeadcountDetail]
	CHECK CONSTRAINT [FK__Departmen__DHL_K__41C3AD93]

GO
ALTER TABLE [dbo].[DepartmentHeadcountDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__PP_St__42B7D1CC]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[DepartmentHeadcountDetail]
	CHECK CONSTRAINT [FK__Departmen__PP_St__42B7D1CC]

GO
ALTER TABLE [dbo].[DepartmentHeadcountDetail] SET (LOCK_ESCALATION = TABLE)
GO
