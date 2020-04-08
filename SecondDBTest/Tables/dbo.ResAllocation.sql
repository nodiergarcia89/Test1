SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResAllocation] (
		[RA_Key]        [int] IDENTITY(1, 1) NOT NULL,
		[RE_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RA_Date]       [float] NULL,
		[RA_Status]     [smallint] NOT NULL,
		[RA_Type]       [int] NULL,
		[LH_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ResAlloc__D390E2F6231F2AE2]
		PRIMARY KEY
		CLUSTERED
		([RA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResAllocation]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAlloca__RE_Co__0915401C]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResAllocation]
	CHECK CONSTRAINT [FK__ResAlloca__RE_Co__0915401C]

GO
CREATE NONCLUSTERED INDEX [RA_ResDateStatusIndex]
	ON [dbo].[ResAllocation] ([RE_Code], [RA_Date], [RA_Status])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResAllocation] SET (LOCK_ESCALATION = TABLE)
GO
