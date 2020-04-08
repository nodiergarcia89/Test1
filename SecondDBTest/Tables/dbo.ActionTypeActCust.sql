SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionTypeActCust] (
		[AT_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CF_Key]            [int] NOT NULL,
		[ATA_Order]         [int] NULL,
		[CF_KeyMapping]     [int] NULL,
		CONSTRAINT [PK__ActionTy__41E9C4C13A81B327]
		PRIMARY KEY
		CLUSTERED
		([AT_Code], [CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionTypeActCust]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__AT_Co__2838E5BA]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ActionTypeActCust]
	CHECK CONSTRAINT [FK__ActionTyp__AT_Co__2838E5BA]

GO
ALTER TABLE [dbo].[ActionTypeActCust]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__CF_Ke__292D09F3]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[ActionTypeActCust]
	CHECK CONSTRAINT [FK__ActionTyp__CF_Ke__292D09F3]

GO
ALTER TABLE [dbo].[ActionTypeActCust] SET (LOCK_ESCALATION = TABLE)
GO
