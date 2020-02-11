SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Budget] (
		[BU_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BU_Desc]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BU_AutoNum]             [int] NULL,
		[BU_Prefix]              [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BU_FromDate]            [float] NULL,
		[BU_ToDate]              [float] NULL,
		[CL_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BU_SubProjects]         [smallint] NULL,
		[AC_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BU_Expenses]            [smallint] NULL,
		[BU_BudgetHours]         [float] NULL,
		[BU_BudgetCost]          [float] NULL,
		[BU_BudgetCharge]        [float] NULL,
		[BU_BudgetExpCost]       [float] NULL,
		[BU_BudgetExpCharge]     [float] NULL,
		[BU_ActualHours]         [float] NULL,
		[BU_ActualCost]          [float] NULL,
		[BU_ActualCharge]        [float] NULL,
		[BU_ActualExpCost]       [float] NULL,
		[BU_ActualExpCharge]     [float] NULL,
		[BU_Notes]               [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BU_LastEditDate]        [float] NULL,
		[BU_LastEdit]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeRole]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Budget__26EAE56A681373AD]
		PRIMARY KEY
		CLUSTERED
		([BU_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Budget]
	WITH CHECK
	ADD CONSTRAINT [FK__Budget__AC_Code__6FBF826D]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[Budget]
	CHECK CONSTRAINT [FK__Budget__AC_Code__6FBF826D]

GO
ALTER TABLE [dbo].[Budget]
	WITH CHECK
	ADD CONSTRAINT [FK__Budget__CL_Code__70B3A6A6]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[Budget]
	CHECK CONSTRAINT [FK__Budget__CL_Code__70B3A6A6]

GO
ALTER TABLE [dbo].[Budget]
	WITH CHECK
	ADD CONSTRAINT [FK__Budget__PR_Code__71A7CADF]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Budget]
	CHECK CONSTRAINT [FK__Budget__PR_Code__71A7CADF]

GO
ALTER TABLE [dbo].[Budget]
	WITH CHECK
	ADD CONSTRAINT [FK__Budget__RE_Code__729BEF18]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Budget]
	CHECK CONSTRAINT [FK__Budget__RE_Code__729BEF18]

GO
ALTER TABLE [dbo].[Budget]
	WITH CHECK
	ADD CONSTRAINT [FK__Budget__RE_CodeR__73901351]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Budget]
	CHECK CONSTRAINT [FK__Budget__RE_CodeR__73901351]

GO
ALTER TABLE [dbo].[Budget] SET (LOCK_ESCALATION = TABLE)
GO
