SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentProfile] (
		[DPR_Key]                 [int] IDENTITY(1, 1) NOT NULL,
		[DE_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DPR_Desc]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DPR_Status]              [int] NOT NULL,
		[DPR_Type]                [int] NULL,
		[DPM_Key]                 [int] NULL,
		[LH_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DPR_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DPR_EditOn]              [float] NULL,
		[DPR_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DPR_LastEditDate]        [float] NULL,
		CONSTRAINT [PK__Departme__8BACC3F560FC61CA]
		PRIMARY KEY
		CLUSTERED
		([DPR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentProfile]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CC_Co__4870AB22]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[DepartmentProfile]
	CHECK CONSTRAINT [FK__Departmen__CC_Co__4870AB22]

GO
ALTER TABLE [dbo].[DepartmentProfile]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__CU_Co__4964CF5B]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[DepartmentProfile]
	CHECK CONSTRAINT [FK__Departmen__CU_Co__4964CF5B]

GO
ALTER TABLE [dbo].[DepartmentProfile]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DE_Co__4A58F394]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[DepartmentProfile]
	CHECK CONSTRAINT [FK__Departmen__DE_Co__4A58F394]

GO
ALTER TABLE [dbo].[DepartmentProfile]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DPM_K__4B4D17CD]
	FOREIGN KEY ([DPM_Key]) REFERENCES [dbo].[DepartmentProfileModel] ([DPM_Key])
ALTER TABLE [dbo].[DepartmentProfile]
	CHECK CONSTRAINT [FK__Departmen__DPM_K__4B4D17CD]

GO
ALTER TABLE [dbo].[DepartmentProfile]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__LH_Co__4C413C06]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[DepartmentProfile]
	CHECK CONSTRAINT [FK__Departmen__LH_Co__4C413C06]

GO
CREATE NONCLUSTERED INDEX [DPR_DeptStatusModelIndex]
	ON [dbo].[DepartmentProfile] ([DE_Code], [DPR_Status], [DPM_Key], [DPR_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DepartmentProfile] SET (LOCK_ESCALATION = TABLE)
GO
