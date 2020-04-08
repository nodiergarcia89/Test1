SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillingInvoiceType] (
		[BIT_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BIT_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BIT_Active]           [smallint] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BIT_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__BillingI__8B044D665CA1C101]
		PRIMARY KEY
		CLUSTERED
		([BIT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BillingInvoiceType] SET (LOCK_ESCALATION = TABLE)
GO
