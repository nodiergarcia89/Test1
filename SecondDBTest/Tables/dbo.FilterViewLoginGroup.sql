SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FilterViewLoginGroup] (
		[FV_Key]      [int] NOT NULL,
		[LG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__FilterVi__2075A9C11E05700A]
		PRIMARY KEY
		CLUSTERED
		([FV_Key], [LG_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[FilterViewLoginGroup]
	WITH CHECK
	ADD CONSTRAINT [FK__FilterVie__FV_Ke__66F53242]
	FOREIGN KEY ([FV_Key]) REFERENCES [dbo].[FilterView] ([FV_Key])
ALTER TABLE [dbo].[FilterViewLoginGroup]
	CHECK CONSTRAINT [FK__FilterVie__FV_Ke__66F53242]

GO
ALTER TABLE [dbo].[FilterViewLoginGroup]
	WITH CHECK
	ADD CONSTRAINT [FK__FilterVie__LG_Co__67E9567B]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[FilterViewLoginGroup]
	CHECK CONSTRAINT [FK__FilterVie__LG_Co__67E9567B]

GO
ALTER TABLE [dbo].[FilterViewLoginGroup] SET (LOCK_ESCALATION = TABLE)
GO
