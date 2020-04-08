SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResPrjCharge] (
		[RE_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CH_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RC_Overtime]     [smallint] NOT NULL,
		CONSTRAINT [PK__ResPrjCh__59C0F70D67C95AEA]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [PR_Code], [CH_Code], [RC_Overtime])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResPrjCharge]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPrjCha__CH_Co__288DEB75]
	FOREIGN KEY ([CH_Code]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[ResPrjCharge]
	CHECK CONSTRAINT [FK__ResPrjCha__CH_Co__288DEB75]

GO
ALTER TABLE [dbo].[ResPrjCharge]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPrjCha__PR_Co__29820FAE]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ResPrjCharge]
	CHECK CONSTRAINT [FK__ResPrjCha__PR_Co__29820FAE]

GO
ALTER TABLE [dbo].[ResPrjCharge]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPrjCha__RE_Co__2A7633E7]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResPrjCharge]
	CHECK CONSTRAINT [FK__ResPrjCha__RE_Co__2A7633E7]

GO
ALTER TABLE [dbo].[ResPrjCharge] SET (LOCK_ESCALATION = TABLE)
GO
