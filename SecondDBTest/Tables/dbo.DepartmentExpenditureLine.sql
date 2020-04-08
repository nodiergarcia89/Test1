SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentExpenditureLine] (
		[DEL_Key]         [int] IDENTITY(1, 1) NOT NULL,
		[DPR_Key]         [int] NOT NULL,
		[DEL_Ordinal]     [int] NULL,
		[CC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DEL_Desc]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Departme__0E8FBAD3558AAF1E]
		PRIMARY KEY
		CLUSTERED
		([DEL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CC_Co__3DF31CAF]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	CHECK CONSTRAINT [FK__Departmen__CC_Co__3DF31CAF]

GO
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CU_Co__3EE740E8]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	CHECK CONSTRAINT [FK__Departmen__CU_Co__3EE740E8]

GO
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DPR_K__3FDB6521]
	FOREIGN KEY ([DPR_Key]) REFERENCES [dbo].[DepartmentProfile] ([DPR_Key])
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	CHECK CONSTRAINT [FK__Departmen__DPR_K__3FDB6521]

GO
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__NC_Co__40CF895A]
	FOREIGN KEY ([NC_Code]) REFERENCES [dbo].[Nominal] ([NC_Code])
ALTER TABLE [dbo].[DepartmentExpenditureLine]
	CHECK CONSTRAINT [FK__Departmen__NC_Co__40CF895A]

GO
CREATE NONCLUSTERED INDEX [DEL_CostCentreIndex]
	ON [dbo].[DepartmentExpenditureLine] ([CC_Code], [DEL_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DEL_ProfileCostCentreIndex]
	ON [dbo].[DepartmentExpenditureLine] ([DPR_Key], [CC_Code], [DEL_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DepartmentExpenditureLine] SET (LOCK_ESCALATION = TABLE)
GO
