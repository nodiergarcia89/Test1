SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgForecastCafe] (
		[CodArticulo]          [int] NOT NULL,
		[CodCentro]            [int] NOT NULL,
		[Año]                  [smallint] NOT NULL,
		[Mes]                  [smallint] NOT NULL,
		[PrevKgsCafe]          [numeric](11, 2) NOT NULL,
		[create_timestamp]     [datetime] NULL,
		[update_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgForecastCafe]
		PRIMARY KEY
		CLUSTERED
		([CodArticulo], [CodCentro], [Año], [Mes])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgForecastCafe] SET (LOCK_ESCALATION = TABLE)
GO
