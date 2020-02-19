SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BackupSystemAccess] (
		[US_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SYP_Product]     [int] NULL
)
GO
ALTER TABLE [dbo].[BackupSystemAccess] SET (LOCK_ESCALATION = TABLE)
GO
