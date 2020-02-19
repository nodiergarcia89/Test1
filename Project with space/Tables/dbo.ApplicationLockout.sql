SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ApplicationLockout] (
		[APL_Key]          [int] IDENTITY(1, 1) NOT NULL,
		[APL_UserID]       [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[APL_DateTime]     [float] NULL,
		CONSTRAINT [unqUserID]
		UNIQUE
		NONCLUSTERED
		([APL_UserID])
		ON [PRIMARY],
		CONSTRAINT [PK__Applicat__C809223D73BA3083]
		PRIMARY KEY
		CLUSTERED
		([APL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ApplicationLockout] SET (LOCK_ESCALATION = TABLE)
GO
