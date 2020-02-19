SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogonAudit] (
		[LOA_Key]           [int] IDENTITY(1, 1) NOT NULL,
		[US_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Desc]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LOA_Date]          [float] NULL,
		[LOA_EventTime]     [float] NULL,
		[LOA_Type]          [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__LogonAud__9189B072125EB334]
		PRIMARY KEY
		CLUSTERED
		([LOA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LogonAudit] SET (LOCK_ESCALATION = TABLE)
GO
