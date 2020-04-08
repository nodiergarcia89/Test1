SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliverableTypeCustomFields] (
		[DVT_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CF_Key]       [int] NOT NULL,
		CONSTRAINT [PK__Delivera__C9AE06C54DE98D56]
		PRIMARY KEY
		CLUSTERED
		([DVT_Code], [CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableTypeCustomFields]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__CF_Ke__3A228BCB]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[DeliverableTypeCustomFields]
	CHECK CONSTRAINT [FK__Deliverab__CF_Ke__3A228BCB]

GO
ALTER TABLE [dbo].[DeliverableTypeCustomFields]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DVT_C__3B16B004]
	FOREIGN KEY ([DVT_Code]) REFERENCES [dbo].[DeliverableType] ([DVT_Code])
ALTER TABLE [dbo].[DeliverableTypeCustomFields]
	CHECK CONSTRAINT [FK__Deliverab__DVT_C__3B16B004]

GO
ALTER TABLE [dbo].[DeliverableTypeCustomFields] SET (LOCK_ESCALATION = TABLE)
GO
