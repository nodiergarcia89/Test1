SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Tabla1] (
		[codempresa]             [int] NULL,
		[codtarifa]              [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[codmagnitud]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[codarticulo]            [int] NULL,
		[canminima]              [int] NOT NULL,
		[prearticulo]            [numeric](38, 6) NULL,
		[flapremagnitud]         [int] NOT NULL,
		[tcpDto01Def]            [int] NULL,
		[tcpDto02Def]            [int] NULL,
		[tcpDto01Max]            [int] NULL,
		[tcpDto02Max]            [int] NULL,
		[PuntosSinDto]           [int] NOT NULL,
		[PuntosConDto]           [int] NOT NULL,
		[flaPuntosUnitarios]     [int] NOT NULL,
		[Origen]                 [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmp_Tabla1] SET (LOCK_ESCALATION = TABLE)
GO
