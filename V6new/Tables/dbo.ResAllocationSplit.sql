SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResAllocationSplit] (
		[RA_Key]          [int] NOT NULL,
		[RAS_Index]       [int] NOT NULL,
		[RE_CodeRole]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NC_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RAS_Ratio]       [float] NULL,
		CONSTRAINT [PK__ResAlloc__2D0E46E726EFBBC6]
		PRIMARY KEY
		CLUSTERED
		([RA_Key], [RAS_Index])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResAllocationSplit]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAlloca__CC_Co__0A096455]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[ResAllocationSplit]
	CHECK CONSTRAINT [FK__ResAlloca__CC_Co__0A096455]

GO
ALTER TABLE [dbo].[ResAllocationSplit]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAlloca__DE_Co__0AFD888E]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[ResAllocationSplit]
	CHECK CONSTRAINT [FK__ResAlloca__DE_Co__0AFD888E]

GO
ALTER TABLE [dbo].[ResAllocationSplit]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAlloca__NC_Co__0BF1ACC7]
	FOREIGN KEY ([NC_Code]) REFERENCES [dbo].[Nominal] ([NC_Code])
ALTER TABLE [dbo].[ResAllocationSplit]
	CHECK CONSTRAINT [FK__ResAlloca__NC_Co__0BF1ACC7]

GO
ALTER TABLE [dbo].[ResAllocationSplit]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAlloca__RA_Ke__0CE5D100]
	FOREIGN KEY ([RA_Key]) REFERENCES [dbo].[ResAllocation] ([RA_Key])
ALTER TABLE [dbo].[ResAllocationSplit]
	CHECK CONSTRAINT [FK__ResAlloca__RA_Ke__0CE5D100]

GO
ALTER TABLE [dbo].[ResAllocationSplit]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAlloca__RE_Co__0DD9F539]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResAllocationSplit]
	CHECK CONSTRAINT [FK__ResAlloca__RE_Co__0DD9F539]

GO
ALTER TABLE [dbo].[ResAllocationSplit] SET (LOCK_ESCALATION = TABLE)
GO
