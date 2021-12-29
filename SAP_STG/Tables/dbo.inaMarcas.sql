SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaMarcas] (
		[CodMarca]         [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Marca]            [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Hashtag]          [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Ina]              [bit] NOT NULL,
		[Folleto]          [bit] NOT NULL,
		[Complementos]     [bit] NULL,
		[Logo]             [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_inaMarcas_1]
		PRIMARY KEY
		CLUSTERED
		([CodMarca])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaMarcas]
	ADD
	CONSTRAINT [DF_inaMarcas_Folleto]
	DEFAULT ((0)) FOR [Folleto]
GO
ALTER TABLE [dbo].[inaMarcas] SET (LOCK_ESCALATION = TABLE)
GO
