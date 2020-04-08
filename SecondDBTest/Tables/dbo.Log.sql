SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log] (
		[LOG_ID]           [int] IDENTITY(1, 1) NOT NULL,
		[LOG_Tag]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LOG_Msg]          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LOG_DateTime]     [float] NULL,
		CONSTRAINT [PK__Log__4364C8825C02A283]
		PRIMARY KEY
		CLUSTERED
		([LOG_ID])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Log] SET (LOCK_ESCALATION = TABLE)
GO
