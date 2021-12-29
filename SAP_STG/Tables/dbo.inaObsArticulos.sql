SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaObsArticulos] (
		[CodEmpresa]      [int] NOT NULL,
		[CodArticulo]     [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumLinea]        [int] NOT NULL,
		[Texto]           [char](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_inaObsArticulos]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodArticulo], [NumLinea])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaObsArticulos] SET (LOCK_ESCALATION = TABLE)
GO
