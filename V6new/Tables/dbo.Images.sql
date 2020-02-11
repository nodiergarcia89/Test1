SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Images] (
		[IMG_Code]           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IMG_BinaryData]     [image] NULL,
		[IMG_EntityCode]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ID]                 [int] IDENTITY(1, 1) NOT NULL,
		CONSTRAINT [PK__Images__3214EC2725A691D2]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [IMG_CodeEntityIndex]
	ON [dbo].[Images] ([IMG_Code], [IMG_EntityCode])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Images] SET (LOCK_ESCALATION = TABLE)
GO
