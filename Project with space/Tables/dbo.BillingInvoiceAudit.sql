SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingInvoiceAudit] (
		[BIA_Key]               [int] IDENTITY(1, 1) NOT NULL,
		[BI_Key]                [int] NOT NULL,
		[BIA_OriginalState]     [int] NULL,
		[BIA_NewState]          [int] NOT NULL,
		[BIA_Reason]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BIA_DateTime]          [float] NOT NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__BillingI__89C1989B4D5F7D71]
		PRIMARY KEY
		CLUSTERED
		([BIA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingInvoiceAudit]
	WITH CHECK
	ADD CONSTRAINT [FK__BillingIn__BI_Ke__5DA0D232]
	FOREIGN KEY ([BI_Key]) REFERENCES [dbo].[BillingInvoice] ([BI_Key])
ALTER TABLE [dbo].[BillingInvoiceAudit]
	CHECK CONSTRAINT [FK__BillingIn__BI_Ke__5DA0D232]

GO
ALTER TABLE [dbo].[BillingInvoiceAudit] SET (LOCK_ESCALATION = TABLE)
GO
