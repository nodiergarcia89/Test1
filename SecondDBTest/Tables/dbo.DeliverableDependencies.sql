SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DeliverableDependencies] (
		[DD_ChildDVKey]      [int] NOT NULL,
		[DD_ParentDVKey]     [int] NOT NULL,
		CONSTRAINT [PK__Delivera__268D560C4277DAAA]
		PRIMARY KEY
		CLUSTERED
		([DD_ChildDVKey], [DD_ParentDVKey])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableDependencies]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DD_Ch__3651FAE7]
	FOREIGN KEY ([DD_ChildDVKey]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[DeliverableDependencies]
	CHECK CONSTRAINT [FK__Deliverab__DD_Ch__3651FAE7]

GO
ALTER TABLE [dbo].[DeliverableDependencies]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DD_Pa__37461F20]
	FOREIGN KEY ([DD_ParentDVKey]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[DeliverableDependencies]
	CHECK CONSTRAINT [FK__Deliverab__DD_Pa__37461F20]

GO
CREATE NONCLUSTERED INDEX [DD_ParentChildIndex]
	ON [dbo].[DeliverableDependencies] ([DD_ParentDVKey], [DD_ChildDVKey])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeliverableDependencies] SET (LOCK_ESCALATION = TABLE)
GO
