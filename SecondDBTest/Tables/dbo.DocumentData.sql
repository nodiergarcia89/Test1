SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentData] (
		[DH_Key]            [int] NOT NULL,
		[DD_BinaryData]     [varbinary](max) NULL,
		CONSTRAINT [PK__Document__CCCBB9B37BB05806]
		PRIMARY KEY
		CLUSTERED
		([DH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DocumentData]
	WITH CHECK
	ADD CONSTRAINT [FK__DocumentD__DH_Ke__54D68207]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[DocumentData]
	CHECK CONSTRAINT [FK__DocumentD__DH_Ke__54D68207]

GO
ALTER TABLE [dbo].[DocumentData] SET (LOCK_ESCALATION = TABLE)
GO
