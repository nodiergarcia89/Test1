SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActivityTimeshtCust] (
		[AC_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CF_Key]        [int] NOT NULL,
		[ATA_Order]     [int] NULL,
		CONSTRAINT [PK__Activity__DE839C41628FA481]
		PRIMARY KEY
		CLUSTERED
		([AC_Code], [CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActivityTimeshtCust]
	WITH CHECK
	ADD CONSTRAINT [FK__ActivityT__AC_Co__386F4D83]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[ActivityTimeshtCust]
	CHECK CONSTRAINT [FK__ActivityT__AC_Co__386F4D83]

GO
ALTER TABLE [dbo].[ActivityTimeshtCust]
	WITH CHECK
	ADD CONSTRAINT [FK__ActivityT__CF_Ke__396371BC]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[ActivityTimeshtCust]
	CHECK CONSTRAINT [FK__ActivityT__CF_Ke__396371BC]

GO
ALTER TABLE [dbo].[ActivityTimeshtCust] SET (LOCK_ESCALATION = TABLE)
GO
