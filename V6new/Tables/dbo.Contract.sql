SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contract] (
		[CT_Number]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CT_StartDate]           [float] NULL,
		[CT_EndDate]             [float] NULL,
		[CT_BudgetValue]         [float] NULL,
		[CT_Confirmed]           [smallint] NOT NULL,
		[CT_Active]              [smallint] NOT NULL,
		[CT_Notes]               [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CT_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CT_EditOn]              [float] NULL,
		[CT_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CT_LastEditDate]        [float] NOT NULL,
		[CT_LastEdit]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Contract__60B9BD834A4E069C]
		PRIMARY KEY
		CLUSTERED
		([CT_Number])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Contract]
	WITH CHECK
	ADD CONSTRAINT [FK__Contract__CC_Cod__1308BEAA]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[Contract]
	CHECK CONSTRAINT [FK__Contract__CC_Cod__1308BEAA]

GO
ALTER TABLE [dbo].[Contract]
	WITH CHECK
	ADD CONSTRAINT [FK__Contract__CL_Cod__13FCE2E3]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[Contract]
	CHECK CONSTRAINT [FK__Contract__CL_Cod__13FCE2E3]

GO
ALTER TABLE [dbo].[Contract]
	WITH CHECK
	ADD CONSTRAINT [FK__Contract__RE_Cod__14F1071C]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Contract]
	CHECK CONSTRAINT [FK__Contract__RE_Cod__14F1071C]

GO
CREATE NONCLUSTERED INDEX [CT_Resource]
	ON [dbo].[Contract] ([RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contract] SET (LOCK_ESCALATION = TABLE)
GO
