SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvoiceDetail] (
		[ID_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[IH_Key]                  [int] NOT NULL,
		[PR_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ID_Desc]                 [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NC_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ID_CalcNetTotal]         [float] NULL,
		[ID_NetTotal]             [float] NULL,
		[ID_SystemNetTotal]       [float] NULL,
		[ID_Vat]                  [real] NULL,
		[ID_GrossTotal]           [float] NULL,
		[ID_SystemGrossTotal]     [float] NULL,
		[ID_LastEdit]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_Key]                  [int] NULL,
		[MS_Key]                  [int] NULL,
		[ID_PORef]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ID_Units]                [float] NULL,
		CONSTRAINT [PK__InvoiceD__2DF994E63118447E]
		PRIMARY KEY
		CLUSTERED
		([ID_Key])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [ID_InvoiceHeaderKey]
	ON [dbo].[InvoiceDetail] ([IH_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ID_MilestoneIndex]
	ON [dbo].[InvoiceDetail] ([MS_Key], [IH_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ID_ProjectIndex]
	ON [dbo].[InvoiceDetail] ([PR_Code], [IH_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ID_TaskIndex]
	ON [dbo].[InvoiceDetail] ([TA_Key], [IH_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[InvoiceDetail] SET (LOCK_ESCALATION = TABLE)
GO
