SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgForecast_tmp] (
		[F1]     [int] NULL,
		[F2]     [int] NULL,
		[F3]     [numeric](11, 2) NULL,
		[F4]     [numeric](11, 2) NULL,
		[F5]     [numeric](11, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgForecast_tmp] SET (LOCK_ESCALATION = TABLE)
GO
