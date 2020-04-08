SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvoiceHeader] (
		[IH_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[CU_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_FilterFromDate]       [float] NULL,
		[IH_FilterToDate]         [float] NULL,
		[IH_FilterAllPrj]         [smallint] NULL,
		[IH_FilterAllAct]         [smallint] NULL,
		[IH_FilterAllRes]         [smallint] NULL,
		[IH_DisplayOptions]       [int] NULL,
		[IH_InvoicePrefix]        [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_InvoiceNo]            [int] NULL,
		[IH_Reference]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_Date]                 [float] NULL,
		[IH_OrderNo]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_PaymentTerms]         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_PRDesc]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_CLDesc]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAccountNo]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Desc]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Phone]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr1]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr2]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr3]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr4]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr5]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr6]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_NetTotal]             [float] NULL,
		[IH_SystemNetTotal]       [float] NULL,
		[IH_GrossTotal]           [float] NULL,
		[IH_SystemGrossTotal]     [float] NULL,
		[IH_Posted]               [smallint] NULL,
		[IH_Notes]                [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IH_LastEditDate]         [float] NULL,
		[IH_LastEdit]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__InvoiceH__E2AB440F38B96646]
		PRIMARY KEY
		CLUSTERED
		([IH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[InvoiceHeader] SET (LOCK_ESCALATION = TABLE)
GO
