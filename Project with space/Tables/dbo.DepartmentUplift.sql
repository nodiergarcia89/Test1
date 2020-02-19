SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentUplift] (
		[DU_Key]           [bigint] IDENTITY(1, 1) NOT NULL,
		[DE_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DU_StartDate]     [int] NOT NULL,
		[DU_Rate]          [float] NOT NULL,
		[CU_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DU_LocalRate]     [float] NULL,
		CONSTRAINT [PK__Departme__06B4BD9B2A6A3847]
		PRIMARY KEY
		CLUSTERED
		([DU_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentUplift]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DE_Co__35D2D7FA]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[DepartmentUplift]
	CHECK CONSTRAINT [FK__Departmen__DE_Co__35D2D7FA]

GO
ALTER TABLE [dbo].[DepartmentUplift]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CU_Co__36C6FC33]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[DepartmentUplift]
	CHECK CONSTRAINT [FK__Departmen__CU_Co__36C6FC33]

GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_DepartmentUpliftCodeStartDate]
	ON [dbo].[DepartmentUplift] ([DE_Code], [DU_StartDate])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DepartmentUplift] SET (LOCK_ESCALATION = TABLE)
GO
