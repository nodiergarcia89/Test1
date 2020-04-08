SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InterestedPrjRes] (
		[PR_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Interest__1A6490FD2D47B39A]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [RE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[InterestedPrjRes]
	WITH CHECK
	ADD CONSTRAINT [FK__Intereste__PR_Co__68DD7AB4]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[InterestedPrjRes]
	CHECK CONSTRAINT [FK__Intereste__PR_Co__68DD7AB4]

GO
ALTER TABLE [dbo].[InterestedPrjRes]
	WITH CHECK
	ADD CONSTRAINT [FK__Intereste__RE_Co__69D19EED]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[InterestedPrjRes]
	CHECK CONSTRAINT [FK__Intereste__RE_Co__69D19EED]

GO
CREATE NONCLUSTERED INDEX [IPR_ResPrjIndex]
	ON [dbo].[InterestedPrjRes] ([RE_Code], [PR_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[InterestedPrjRes] SET (LOCK_ESCALATION = TABLE)
GO
