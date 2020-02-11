SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileDemandLine] (
		[PDL_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[PRF_Key]                  [int] NOT NULL,
		[PDL_Ordinal]              [int] NULL,
		[DE_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LH_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PDL_ClaimedBy]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PDL_ClaimedOn]            [float] NULL,
		[PDL_ClaimOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PDL_ConfirmedUntil]       [float] NULL,
		[PDL_IsHidden]             [smallint] NULL,
		CONSTRAINT [PK__ProfileD__43B2AED572B0FDB1]
		PRIMARY KEY
		CLUSTERED
		([PDL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileDemandLine]
	ADD
	CONSTRAINT [DF__ProfileDe__PDL_I__5FC911C6]
	DEFAULT ((0)) FOR [PDL_IsHidden]
GO
ALTER TABLE [dbo].[ProfileDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__CU_Co__2E7BCEF5]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[ProfileDemandLine]
	CHECK CONSTRAINT [FK__ProfileDe__CU_Co__2E7BCEF5]

GO
ALTER TABLE [dbo].[ProfileDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__DE_Co__2F6FF32E]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[ProfileDemandLine]
	CHECK CONSTRAINT [FK__ProfileDe__DE_Co__2F6FF32E]

GO
ALTER TABLE [dbo].[ProfileDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__LH_Co__30641767]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[ProfileDemandLine]
	CHECK CONSTRAINT [FK__ProfileDe__LH_Co__30641767]

GO
ALTER TABLE [dbo].[ProfileDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__PRF_K__31583BA0]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProfileDemandLine]
	CHECK CONSTRAINT [FK__ProfileDe__PRF_K__31583BA0]

GO
ALTER TABLE [dbo].[ProfileDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__RE_Co__324C5FD9]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProfileDemandLine]
	CHECK CONSTRAINT [FK__ProfileDe__RE_Co__324C5FD9]

GO
ALTER TABLE [dbo].[ProfileDemandLine]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__RE_Co__33408412]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProfileDemandLine]
	CHECK CONSTRAINT [FK__ProfileDe__RE_Co__33408412]

GO
CREATE NONCLUSTERED INDEX [PDL_ProfileDeptIndex]
	ON [dbo].[ProfileDemandLine] ([PRF_Key], [DE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PDL_ProfileRoleIndex]
	ON [dbo].[ProfileDemandLine] ([PRF_Key], [RE_CodeRole], [DE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PDL_RoleDeptIndex]
	ON [dbo].[ProfileDemandLine] ([RE_CodeRole], [DE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProfileDemandLine] SET (LOCK_ESCALATION = TABLE)
GO
