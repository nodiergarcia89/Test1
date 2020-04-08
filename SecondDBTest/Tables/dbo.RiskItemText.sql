SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskItemText] (
		[RI_Key]                  [int] NOT NULL,
		[RI_PlainTextDetails]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RI_FormattedDetails]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__RiskItem__B80925FD22EA20B8]
		PRIMARY KEY
		CLUSTERED
		([RI_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskItemText]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItemT__RI_Ke__4341E1B1]
	FOREIGN KEY ([RI_Key]) REFERENCES [dbo].[RiskItem] ([RI_Key])
ALTER TABLE [dbo].[RiskItemText]
	CHECK CONSTRAINT [FK__RiskItemT__RI_Ke__4341E1B1]

GO
CREATE FULLTEXT INDEX ON [dbo].[RiskItemText]
	([RI_PlainTextDetails] LANGUAGE 1033)
	KEY INDEX [PK__RiskItem__B80925FD22EA20B8]
	ON (FILEGROUP [PRIMARY], [CAT_Risk])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[RiskItemText] SET (LOCK_ESCALATION = TABLE)
GO
