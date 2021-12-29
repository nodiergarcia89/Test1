SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgIna_Archivos] (
		[path]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[name]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ModifyDate]       [datetime] NOT NULL,
		[IsFileSystem]     [bit] NOT NULL,
		[IsFolder]         [bit] NOT NULL,
		[Tipo]             [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumDoc]           [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgIna_Archivos_7_1462296269__K6_3_7]
	ON [dbo].[stgIna_Archivos] ([Tipo])
	INCLUDE ([ModifyDate], [NumDoc])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgIna_Archivos] SET (LOCK_ESCALATION = TABLE)
GO
