SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPasswordHistory] (
		[UPH_Key]                     [int] IDENTITY(1, 1) NOT NULL,
		[US_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPH_Password]                [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPH_PasswordChangedDate]     [float] NULL,
		CONSTRAINT [PK__UserPass__8D5A522874B941B4]
		PRIMARY KEY
		CLUSTERED
		([UPH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserPasswordHistory]
	WITH CHECK
	ADD CONSTRAINT [FK__UserPassw__US_Co__163A3110]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserPasswordHistory]
	CHECK CONSTRAINT [FK__UserPassw__US_Co__163A3110]

GO
CREATE NONCLUSTERED INDEX [UPH_UserCodeDateIndex]
	ON [dbo].[UserPasswordHistory] ([US_Code], [UPH_PasswordChangedDate])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserPasswordHistory] SET (LOCK_ESCALATION = TABLE)
GO
