SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionViewCulture] (
		[AV_Key]       [int] NOT NULL,
		[CLC_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AVC_Name]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ActionVi__41E0F86A59063A47]
		PRIMARY KEY
		CLUSTERED
		([AV_Key], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionViewCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__AV_Ke__33AA9866]
	FOREIGN KEY ([AV_Key]) REFERENCES [dbo].[ActionView] ([AV_Key])
ALTER TABLE [dbo].[ActionViewCulture]
	CHECK CONSTRAINT [FK__ActionVie__AV_Ke__33AA9866]

GO
ALTER TABLE [dbo].[ActionViewCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__CLC_C__349EBC9F]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[ActionViewCulture]
	CHECK CONSTRAINT [FK__ActionVie__CLC_C__349EBC9F]

GO
ALTER TABLE [dbo].[ActionViewCulture] SET (LOCK_ESCALATION = TABLE)
GO
