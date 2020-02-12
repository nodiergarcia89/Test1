SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResPrj] (
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ResPrj__E1C02E2F63F8CA06]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResPrj]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPrj__PR_Code__26A5A303]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ResPrj]
	CHECK CONSTRAINT [FK__ResPrj__PR_Code__26A5A303]

GO
ALTER TABLE [dbo].[ResPrj]
	WITH CHECK
	ADD CONSTRAINT [FK__ResPrj__RE_Code__2799C73C]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResPrj]
	CHECK CONSTRAINT [FK__ResPrj__RE_Code__2799C73C]

GO
CREATE NONCLUSTERED INDEX [RP_PrjResIndex]
	ON [dbo].[ResPrj] ([PR_Code], [RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResPrj] SET (LOCK_ESCALATION = TABLE)
GO