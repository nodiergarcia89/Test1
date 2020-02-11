SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CustomFieldTriggers] (
		[CFT_Key]             [int] IDENTITY(1, 1) NOT NULL,
		[CF_Key]              [int] NOT NULL,
		[CFT_TriggerType]     [bigint] NOT NULL,
		CONSTRAINT [PK__CustomFi__048117930B27A5C0]
		PRIMARY KEY
		CLUSTERED
		([CFT_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomFieldTriggers]
	WITH CHECK
	ADD CONSTRAINT [FK__CustomFie__CF_Ke__25276EE5]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[CustomFieldTriggers]
	CHECK CONSTRAINT [FK__CustomFie__CF_Ke__25276EE5]

GO
ALTER TABLE [dbo].[CustomFieldTriggers] SET (LOCK_ESCALATION = TABLE)
GO
