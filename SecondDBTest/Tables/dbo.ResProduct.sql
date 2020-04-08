SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResProduct] (
		[RE_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SYP_Product]     [int] NOT NULL,
		CONSTRAINT [PK__ResProdu__F164A4806B99EBCE]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [SYP_Product])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResProduct]
	WITH CHECK
	ADD CONSTRAINT [FK__ResProduc__RE_Co__2B6A5820]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResProduct]
	CHECK CONSTRAINT [FK__ResProduc__RE_Co__2B6A5820]

GO
ALTER TABLE [dbo].[ResProduct] SET (LOCK_ESCALATION = TABLE)
GO
