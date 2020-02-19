SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ActionViewContexts] (
		[AV_Key]       [int] NOT NULL,
		[CA_Key]       [int] NOT NULL,
		[AVC_Type]     [smallint] NULL,
		CONSTRAINT [PK__ActionVi__93D53D335535A963]
		PRIMARY KEY
		CLUSTERED
		([AV_Key], [CA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionViewContexts]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__AV_Ke__31C24FF4]
	FOREIGN KEY ([AV_Key]) REFERENCES [dbo].[ActionView] ([AV_Key])
ALTER TABLE [dbo].[ActionViewContexts]
	CHECK CONSTRAINT [FK__ActionVie__AV_Ke__31C24FF4]

GO
ALTER TABLE [dbo].[ActionViewContexts]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__CA_Ke__32B6742D]
	FOREIGN KEY ([CA_Key]) REFERENCES [dbo].[ContextAreas] ([CA_Key])
ALTER TABLE [dbo].[ActionViewContexts]
	CHECK CONSTRAINT [FK__ActionVie__CA_Ke__32B6742D]

GO
ALTER TABLE [dbo].[ActionViewContexts] SET (LOCK_ESCALATION = TABLE)
GO
