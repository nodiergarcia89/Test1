SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResRole] (
		[RE_CodeRes]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RR_Ratio]        [float] NOT NULL,
		CONSTRAINT [PK__ResRole__9B8F612F6F6A7CB2]
		PRIMARY KEY
		CLUSTERED
		([RE_CodeRes], [RE_CodeRole])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResRole]
	WITH CHECK
	ADD CONSTRAINT [FK__ResRole__RE_Code__2C5E7C59]
	FOREIGN KEY ([RE_CodeRes]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResRole]
	CHECK CONSTRAINT [FK__ResRole__RE_Code__2C5E7C59]

GO
ALTER TABLE [dbo].[ResRole]
	WITH CHECK
	ADD CONSTRAINT [FK__ResRole__RE_Code__2D52A092]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResRole]
	CHECK CONSTRAINT [FK__ResRole__RE_Code__2D52A092]

GO
CREATE NONCLUSTERED INDEX [RR_RoleIndex]
	ON [dbo].[ResRole] ([RE_CodeRole])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResRole] SET (LOCK_ESCALATION = TABLE)
GO
