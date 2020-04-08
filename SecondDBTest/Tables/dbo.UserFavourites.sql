SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserFavourites] (
		[UF_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UF_Type]             [smallint] NOT NULL,
		[UF_KeyIdentity]      [int] NULL,
		[UF_CodeIdentity]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_Key]              [int] NULL,
		[AV_Key]              [int] NULL,
		CONSTRAINT [PK__UserFavo__4D34F03760B24907]
		PRIMARY KEY
		CLUSTERED
		([UF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserFavourites]
	WITH CHECK
	ADD CONSTRAINT [FK__UserFavou__US_Co__11757BF3]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserFavourites]
	CHECK CONSTRAINT [FK__UserFavou__US_Co__11757BF3]

GO
CREATE NONCLUSTERED INDEX [UF_UserType]
	ON [dbo].[UserFavourites] ([US_Code], [UF_Type])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserFavourites] SET (LOCK_ESCALATION = TABLE)
GO
