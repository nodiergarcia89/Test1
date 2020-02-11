SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DepartmentExpenditureDetail] (
		[DEL_Key]            [int] NOT NULL,
		[PP_StartDate]       [float] NOT NULL,
		[PP_EndDate]         [float] NOT NULL,
		[DED_LocalCost]      [float] NOT NULL,
		[DED_SystemCost]     [float] NOT NULL,
		CONSTRAINT [PK__Departme__075384E351BA1E3A]
		PRIMARY KEY
		CLUSTERED
		([DEL_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentExpenditureDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DEL_K__3C0AD43D]
	FOREIGN KEY ([DEL_Key]) REFERENCES [dbo].[DepartmentExpenditureLine] ([DEL_Key])
ALTER TABLE [dbo].[DepartmentExpenditureDetail]
	CHECK CONSTRAINT [FK__Departmen__DEL_K__3C0AD43D]

GO
ALTER TABLE [dbo].[DepartmentExpenditureDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__PP_St__3CFEF876]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[DepartmentExpenditureDetail]
	CHECK CONSTRAINT [FK__Departmen__PP_St__3CFEF876]

GO
ALTER TABLE [dbo].[DepartmentExpenditureDetail] SET (LOCK_ESCALATION = TABLE)
GO
