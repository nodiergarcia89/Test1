SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TypeExpenseCust] (
		[TY_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CF_Key]       [int] NOT NULL,
		[TE_Order]     [int] NULL,
		CONSTRAINT [PK__TypeExpe__3D6FDA075CE1B823]
		PRIMARY KEY
		CLUSTERED
		([TY_Code], [CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TypeExpenseCust]
	WITH CHECK
	ADD CONSTRAINT [FK__TypeExpen__CF_Ke__0F8D3381]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[TypeExpenseCust]
	CHECK CONSTRAINT [FK__TypeExpen__CF_Ke__0F8D3381]

GO
ALTER TABLE [dbo].[TypeExpenseCust]
	WITH CHECK
	ADD CONSTRAINT [FK__TypeExpen__TY_Co__108157BA]
	FOREIGN KEY ([TY_Code]) REFERENCES [dbo].[Type] ([TY_Code])
ALTER TABLE [dbo].[TypeExpenseCust]
	CHECK CONSTRAINT [FK__TypeExpen__TY_Co__108157BA]

GO
ALTER TABLE [dbo].[TypeExpenseCust] SET (LOCK_ESCALATION = TABLE)
GO
