SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Deliverable] (
		[DV_Key]                 [int] IDENTITY(1, 1) NOT NULL,
		[DV_Name]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DV_Ordinal]             [int] NOT NULL,
		[RE_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DVT_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DV_Audit]               [smallint] NOT NULL,
		[DV_Desc]                [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DV_Status]              [int] NOT NULL,
		[DV_DeliveryDate]        [float] NOT NULL,
		[DV_Mandatory]           [smallint] NOT NULL,
		[DV_RescheduleCount]     [int] NOT NULL,
		[DV_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DV_EditOn]              [float] NULL,
		[DV_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DV_LastEditDate]        [float] NOT NULL,
		[DV_PublishTo]           [int] NULL,
		CONSTRAINT [PK__Delivera__F529BF2A27C3E46E]
		PRIMARY KEY
		CLUSTERED
		([DV_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Deliverable]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DVT_C__2CC890AD]
	FOREIGN KEY ([DVT_Code]) REFERENCES [dbo].[DeliverableType] ([DVT_Code])
ALTER TABLE [dbo].[Deliverable]
	CHECK CONSTRAINT [FK__Deliverab__DVT_C__2CC890AD]

GO
ALTER TABLE [dbo].[Deliverable]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__PR_Co__2DBCB4E6]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Deliverable]
	CHECK CONSTRAINT [FK__Deliverab__PR_Co__2DBCB4E6]

GO
ALTER TABLE [dbo].[Deliverable]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__RE_Co__2EB0D91F]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Deliverable]
	CHECK CONSTRAINT [FK__Deliverab__RE_Co__2EB0D91F]

GO
CREATE NONCLUSTERED INDEX [DV_ProjectDateIndex]
	ON [dbo].[Deliverable] ([PR_Code], [DV_DeliveryDate], [DV_Audit])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DV_ResourceDateIndex]
	ON [dbo].[Deliverable] ([RE_Code], [DV_DeliveryDate], [DV_Audit])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DV_TypeDateIndex]
	ON [dbo].[Deliverable] ([DVT_Code], [DV_DeliveryDate], [DV_Audit])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Deliverable] SET (LOCK_ESCALATION = TABLE)
GO
