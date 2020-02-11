SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskItemAttachments] (
		[RI_Key]          [int] NOT NULL,
		[RA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[RiskItemAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItemA__RI_Ke__3D89085B]
	FOREIGN KEY ([RI_Key]) REFERENCES [dbo].[RiskItem] ([RI_Key])
ALTER TABLE [dbo].[RiskItemAttachments]
	CHECK CONSTRAINT [FK__RiskItemA__RI_Ke__3D89085B]

GO
CREATE NONCLUSTERED INDEX [RiskItemAttachments_Index]
	ON [dbo].[RiskItemAttachments] ([RI_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RiskItemAttachments] SET (LOCK_ESCALATION = TABLE)
GO
