SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportImage] (
		[RIMG_Header]     [varbinary](max) NULL,
		[RIMG_Footer]     [varbinary](max) NULL,
		[RIMG_Key]        [int] IDENTITY(1, 1) NOT NULL,
		CONSTRAINT [PK__ReportIm__39635EA3086B34A6]
		PRIMARY KEY
		CLUSTERED
		([RIMG_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportImage] SET (LOCK_ESCALATION = TABLE)
GO
