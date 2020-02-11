SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliverableAuditDependencies] (
		[DAD_Key]                [int] IDENTITY(1, 1) NOT NULL,
		[DV_KeyPrimary]          [int] NOT NULL,
		[DV_KeyAudit]            [int] NOT NULL,
		[DAD_DepType]            [smallint] NULL,
		[DAD_DVPRCode]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DAD_DVPRDesc]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DAD_DVName]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DAD_DVTypeCode]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DAD_DVTypeDesc]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DAD_OriginalDate]       [float] NULL,
		[DAD_DVDeliveryDate]     [float] NULL,
		[DAD_Movement]           [int] NULL,
		[DAD_DVStatus]           [smallint] NULL,
		[DAD_Gap]                [int] NULL,
		CONSTRAINT [PK__Delivera__3059B4FA3335971A]
		PRIMARY KEY
		CLUSTERED
		([DAD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableAuditDependencies]
	WITH CHECK
	ADD CONSTRAINT [FK__DeliverableAudit__32816A03]
	FOREIGN KEY ([DV_KeyPrimary], [DV_KeyAudit]) REFERENCES [dbo].[DeliverableAudit] ([DV_KeyPrimary], [DV_KeyAudit])
ALTER TABLE [dbo].[DeliverableAuditDependencies]
	CHECK CONSTRAINT [FK__DeliverableAudit__32816A03]

GO
CREATE NONCLUSTERED INDEX [DAD_AuditPKIndex]
	ON [dbo].[DeliverableAuditDependencies] ([DV_KeyPrimary], [DV_KeyAudit])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeliverableAuditDependencies] SET (LOCK_ESCALATION = TABLE)
GO
