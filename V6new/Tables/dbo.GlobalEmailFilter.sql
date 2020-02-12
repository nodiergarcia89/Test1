SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalEmailFilter] (
		[GE_EmailFilter]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__GlobalEm__3D9B307921D600EE]
		PRIMARY KEY
		CLUSTERED
		([GE_EmailFilter])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[GlobalEmailFilter] SET (LOCK_ESCALATION = TABLE)
GO