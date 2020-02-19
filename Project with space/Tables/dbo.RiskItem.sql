SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskItem] (
		[RI_Key]                 [int] NOT NULL,
		[RE_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RIT_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RI_DueDate]             [float] NULL,
		[RI_Stage]               [int] NULL,
		[RK_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RI_Status]              [smallint] NULL,
		[RI_Attachments]         [smallint] NULL,
		[RI_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RI_EditOn]              [float] NULL,
		[RI_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RI_LastEditDate]        [float] NULL,
		CONSTRAINT [PK__RiskItem__B80925FD0EE3280B]
		PRIMARY KEY
		CLUSTERED
		([RI_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskItem]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItem__RE_Cod__3AAC9BB0]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[RiskItem]
	CHECK CONSTRAINT [FK__RiskItem__RE_Cod__3AAC9BB0]

GO
ALTER TABLE [dbo].[RiskItem]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItem__RIT_Co__3BA0BFE9]
	FOREIGN KEY ([RIT_Code]) REFERENCES [dbo].[RiskItemType] ([RIT_Code])
ALTER TABLE [dbo].[RiskItem]
	CHECK CONSTRAINT [FK__RiskItem__RIT_Co__3BA0BFE9]

GO
ALTER TABLE [dbo].[RiskItem]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItem__RK_Cod__3C94E422]
	FOREIGN KEY ([RK_Code]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[RiskItem]
	CHECK CONSTRAINT [FK__RiskItem__RK_Cod__3C94E422]

GO
CREATE NONCLUSTERED INDEX [RI_ResIndex]
	ON [dbo].[RiskItem] ([RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RiskItem] SET (LOCK_ESCALATION = TABLE)
GO
