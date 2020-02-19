SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TaskDependencies] (
		[TA_KeyChild]      [int] NOT NULL,
		[TA_KeyParent]     [int] NOT NULL,
		[TD_Type]          [smallint] NULL,
		[TD_Lag]           [float] NULL,
		CONSTRAINT [PK__TaskDepe__FBEFB4C11C0818FF]
		PRIMARY KEY
		CLUSTERED
		([TA_KeyChild], [TA_KeyParent])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TaskDependencies]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskDepen__TA_Ke__6B4FD30B]
	FOREIGN KEY ([TA_KeyChild]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[TaskDependencies]
	CHECK CONSTRAINT [FK__TaskDepen__TA_Ke__6B4FD30B]

GO
ALTER TABLE [dbo].[TaskDependencies]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskDepen__TA_Ke__6C43F744]
	FOREIGN KEY ([TA_KeyParent]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[TaskDependencies]
	CHECK CONSTRAINT [FK__TaskDepen__TA_Ke__6C43F744]

GO
CREATE NONCLUSTERED INDEX [TA_KeyChildIndex]
	ON [dbo].[TaskDependencies] ([TA_KeyChild])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[TaskDependencies] SET (LOCK_ESCALATION = TABLE)
GO
