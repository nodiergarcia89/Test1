SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContextAreas] (
		[CA_Key]      [int] NOT NULL,
		[CA_Name]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CA_Flag]     [int] NULL,
		CONSTRAINT [PK__ContextA__953F843E467D75B8]
		PRIMARY KEY
		CLUSTERED
		([CA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ContextAreas] SET (LOCK_ESCALATION = TABLE)
GO
