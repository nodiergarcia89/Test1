SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResCapability] (
		[RC_Key]           [int] IDENTITY(1, 1) NOT NULL,
		[RE_CodeRes]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NC_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RC_Status]        [smallint] NULL,
		[RC_StartType]     [smallint] NULL,
		[RC_EndType]       [smallint] NULL,
		CONSTRAINT [PK__ResCapab__CED2E0172AC04CAA]
		PRIMARY KEY
		CLUSTERED
		([RC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResCapability]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__CC_Co__0ECE1972]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[ResCapability]
	CHECK CONSTRAINT [FK__ResCapabi__CC_Co__0ECE1972]

GO
ALTER TABLE [dbo].[ResCapability]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__DE_Co__0FC23DAB]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[ResCapability]
	CHECK CONSTRAINT [FK__ResCapabi__DE_Co__0FC23DAB]

GO
ALTER TABLE [dbo].[ResCapability]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__NC_Co__10B661E4]
	FOREIGN KEY ([NC_Code]) REFERENCES [dbo].[Nominal] ([NC_Code])
ALTER TABLE [dbo].[ResCapability]
	CHECK CONSTRAINT [FK__ResCapabi__NC_Co__10B661E4]

GO
ALTER TABLE [dbo].[ResCapability]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__RE_Co__11AA861D]
	FOREIGN KEY ([RE_CodeRes]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResCapability]
	CHECK CONSTRAINT [FK__ResCapabi__RE_Co__11AA861D]

GO
ALTER TABLE [dbo].[ResCapability]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__RE_Co__129EAA56]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResCapability]
	CHECK CONSTRAINT [FK__ResCapabi__RE_Co__129EAA56]

GO
CREATE NONCLUSTERED INDEX [RC_CCNominalStatusIndex]
	ON [dbo].[ResCapability] ([CC_Code], [NC_Code], [RC_Status])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RC_DeptRoleCCStatusIndex]
	ON [dbo].[ResCapability] ([DE_Code], [RE_CodeRole], [RC_Status])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RC_ResRoleDeptStatusIndex]
	ON [dbo].[ResCapability] ([RE_CodeRes], [RE_CodeRole], [DE_Code], [RC_Status])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResCapability] SET (LOCK_ESCALATION = TABLE)
GO
