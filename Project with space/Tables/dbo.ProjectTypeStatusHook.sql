SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProjectTypeStatusHook] (
		[PTSH_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[PT_Key]                [int] NOT NULL,
		[WFS_Key]               [int] NOT NULL,
		[WH_Key]                [int] NOT NULL,
		[PTSH_HookPosition]     [int] NOT NULL,
		CONSTRAINT [PK__ProjectT__4DA6EEB87C1EB7FA]
		PRIMARY KEY
		CLUSTERED
		([PTSH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectTypeStatusHook]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__PT_Ke__012A0591]
	FOREIGN KEY ([PT_Key]) REFERENCES [dbo].[ProjectType] ([PT_Key])
ALTER TABLE [dbo].[ProjectTypeStatusHook]
	CHECK CONSTRAINT [FK__ProjectTy__PT_Ke__012A0591]

GO
ALTER TABLE [dbo].[ProjectTypeStatusHook]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__WFS_K__021E29CA]
	FOREIGN KEY ([WFS_Key]) REFERENCES [dbo].[WorkflowStatus] ([WFS_Key])
ALTER TABLE [dbo].[ProjectTypeStatusHook]
	CHECK CONSTRAINT [FK__ProjectTy__WFS_K__021E29CA]

GO
ALTER TABLE [dbo].[ProjectTypeStatusHook]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__WH_Ke__03124E03]
	FOREIGN KEY ([WH_Key]) REFERENCES [dbo].[WebHooks] ([WH_Key])
ALTER TABLE [dbo].[ProjectTypeStatusHook]
	CHECK CONSTRAINT [FK__ProjectTy__WH_Ke__03124E03]

GO
ALTER TABLE [dbo].[ProjectTypeStatusHook] SET (LOCK_ESCALATION = TABLE)
GO
