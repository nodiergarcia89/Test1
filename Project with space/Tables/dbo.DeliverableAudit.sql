SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliverableAudit] (
		[DV_KeyPrimary]         [int] NOT NULL,
		[DV_KeyAudit]           [int] NOT NULL,
		[DVU_Status]            [int] NOT NULL,
		[DVU_DeliveryDate]      [float] NOT NULL,
		[DVU_Type]              [int] NOT NULL,
		[DVU_Reason]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DVU_DaysOverdue]       [int] NOT NULL,
		[DVU_MonthsOverdue]     [int] NOT NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DVU_DateTime]          [float] NOT NULL,
		CONSTRAINT [PK__Delivera__438A47BC2F650636]
		PRIMARY KEY
		CLUSTERED
		([DV_KeyPrimary], [DV_KeyAudit])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableAudit]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DV_Ke__30992191]
	FOREIGN KEY ([DV_KeyPrimary]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[DeliverableAudit]
	CHECK CONSTRAINT [FK__Deliverab__DV_Ke__30992191]

GO
ALTER TABLE [dbo].[DeliverableAudit]
	WITH CHECK
	ADD CONSTRAINT [FK__Deliverab__DV_Ke__318D45CA]
	FOREIGN KEY ([DV_KeyAudit]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[DeliverableAudit]
	CHECK CONSTRAINT [FK__Deliverab__DV_Ke__318D45CA]

GO
ALTER TABLE [dbo].[DeliverableAudit] SET (LOCK_ESCALATION = TABLE)
GO
