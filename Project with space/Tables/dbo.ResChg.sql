SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResChg] (
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CH_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ResChg__0A54B76732616E72]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [CH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResChg]
	WITH CHECK
	ADD CONSTRAINT [FK__ResChg__CH_Code__157B1701]
	FOREIGN KEY ([CH_Code]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[ResChg]
	CHECK CONSTRAINT [FK__ResChg__CH_Code__157B1701]

GO
ALTER TABLE [dbo].[ResChg]
	WITH CHECK
	ADD CONSTRAINT [FK__ResChg__RE_Code__166F3B3A]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResChg]
	CHECK CONSTRAINT [FK__ResChg__RE_Code__166F3B3A]

GO
CREATE NONCLUSTERED INDEX [RC_ChargeResIndex]
	ON [dbo].[ResChg] ([CH_Code], [RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResChg] SET (LOCK_ESCALATION = TABLE)
GO
