SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaArticulosMultimediaFijo] (
		[CodArticulo]       [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ID]                [int] IDENTITY(1, 1) NOT NULL,
		[hipMultimedia]     [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[desMultimedia]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BajoDemanda]       [tinyint] NULL,
		CONSTRAINT [PK_inaArticulosMultimediaFijo]
		PRIMARY KEY
		CLUSTERED
		([CodArticulo], [ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaArticulosMultimediaFijo]
	ADD
	CONSTRAINT [DF_inaArticulosMultimediaFijo_BajoDemanda]
	DEFAULT ((0)) FOR [BajoDemanda]
GO
ALTER TABLE [dbo].[inaArticulosMultimediaFijo] SET (LOCK_ESCALATION = TABLE)
GO
