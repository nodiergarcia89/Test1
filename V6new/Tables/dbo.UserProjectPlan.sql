SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserProjectPlan] (
		[UPP_ID]                [int] IDENTITY(1, 1) NOT NULL,
		[PR_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PPC_Version]           [int] NOT NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UPP_ExpandedTasks]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__UserProj__EA446A78293A1796]
		PRIMARY KEY
		CLUSTERED
		([UPP_ID])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserProjectPlan] SET (LOCK_ESCALATION = TABLE)
GO
