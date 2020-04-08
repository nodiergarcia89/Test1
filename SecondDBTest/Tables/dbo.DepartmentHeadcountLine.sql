SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentHeadcountLine] (
		[DHL_Key]         [int] IDENTITY(1, 1) NOT NULL,
		[DPR_Key]         [int] NOT NULL,
		[DHL_Ordinal]     [int] NULL,
		[CC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeRole]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DHL_Desc]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Departme__A2DA7B1B5D2BD0E6]
		PRIMARY KEY
		CLUSTERED
		([DHL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CC_Co__43ABF605]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	CHECK CONSTRAINT [FK__Departmen__CC_Co__43ABF605]

GO
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CU_Co__44A01A3E]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	CHECK CONSTRAINT [FK__Departmen__CU_Co__44A01A3E]

GO
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DPR_K__45943E77]
	FOREIGN KEY ([DPR_Key]) REFERENCES [dbo].[DepartmentProfile] ([DPR_Key])
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	CHECK CONSTRAINT [FK__Departmen__DPR_K__45943E77]

GO
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__NC_Co__468862B0]
	FOREIGN KEY ([NC_Code]) REFERENCES [dbo].[Nominal] ([NC_Code])
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	CHECK CONSTRAINT [FK__Departmen__NC_Co__468862B0]

GO
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__RE_Co__477C86E9]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[DepartmentHeadcountLine]
	CHECK CONSTRAINT [FK__Departmen__RE_Co__477C86E9]

GO
CREATE NONCLUSTERED INDEX [DPH_CostCentreIndex]
	ON [dbo].[DepartmentHeadcountLine] ([CC_Code], [DHL_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DPH_DepProfileCostCentreIndex]
	ON [dbo].[DepartmentHeadcountLine] ([DPR_Key], [CC_Code], [DHL_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DPH_DepProfileRoleIndex]
	ON [dbo].[DepartmentHeadcountLine] ([DPR_Key], [RE_CodeRole], [CC_Code], [DHL_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DPH_RoleCostCentreIndex]
	ON [dbo].[DepartmentHeadcountLine] ([RE_CodeRole], [CC_Code], [DHL_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DepartmentHeadcountLine] SET (LOCK_ESCALATION = TABLE)
GO
