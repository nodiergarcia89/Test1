SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Marcas] (
		[codEmpresa]       [int] NOT NULL,
		[nomIPad]          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codReporte]       [int] NOT NULL,
		[datRespuesta]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmp_Marcas] SET (LOCK_ESCALATION = TABLE)
GO
