SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [aux].[inaOrigenesPrecio] (
		[codOrigenPrecio]     [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OrigenPrecio]        [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_inaOrigenesPrecio]
		PRIMARY KEY
		CLUSTERED
		([codOrigenPrecio])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [aux].[inaOrigenesPrecio] SET (LOCK_ESCALATION = TABLE)
GO
