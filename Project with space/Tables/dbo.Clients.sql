SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clients] (
		[CL_Code]                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Desc]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Addr1]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Addr2]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Addr3]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Addr4]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Addr5]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Addr6]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Phone]                      [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Fax]                        [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_VATNumber]                  [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAccountNo]               [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr1]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr2]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr3]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr4]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr5]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvAddr6]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_InvVAT]                     [real] NULL,
		[CL_InvPaymentTerms]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_PassExpenseVATToClient]     [smallint] NULL,
		[CL_AllSecurityGroups]          [smallint] NULL,
		[CL_Agency]                     [smallint] NULL,
		[CL_Notes]                      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Status1]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Status2]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Status3]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_KeyPrimary]                 [int] NULL,
		[CN_KeySecondary]               [int] NULL,
		[CN_KeyAccount]                 [int] NULL,
		[CG_Code]                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Email]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Prefix]                     [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_AutoNum]                    [int] NULL,
		[CL_WebSite]                    [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Active]                        [smallint] NULL,
		[CL_EditBy]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_EditOn]                     [float] NULL,
		[CL_EditOverwriteBy]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_LastEditDate]               [float] NULL,
		[CL_LastEdit]                   [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Clients__B67F15552704CA5F]
		PRIMARY KEY
		CLUSTERED
		([CL_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Clients]
	WITH CHECK
	ADD CONSTRAINT [FK__Clients__CG_Code__06A2E7C5]
	FOREIGN KEY ([CG_Code]) REFERENCES [dbo].[ClientGroups] ([CG_Code])
ALTER TABLE [dbo].[Clients]
	CHECK CONSTRAINT [FK__Clients__CG_Code__06A2E7C5]

GO
ALTER TABLE [dbo].[Clients]
	WITH CHECK
	ADD CONSTRAINT [FK__Clients__CN_KeyA__07970BFE]
	FOREIGN KEY ([CN_KeyAccount]) REFERENCES [dbo].[Contacts] ([CN_Key])
ALTER TABLE [dbo].[Clients]
	CHECK CONSTRAINT [FK__Clients__CN_KeyA__07970BFE]

GO
ALTER TABLE [dbo].[Clients]
	WITH CHECK
	ADD CONSTRAINT [FK__Clients__CN_KeyP__088B3037]
	FOREIGN KEY ([CN_KeyPrimary]) REFERENCES [dbo].[Contacts] ([CN_Key])
ALTER TABLE [dbo].[Clients]
	CHECK CONSTRAINT [FK__Clients__CN_KeyP__088B3037]

GO
ALTER TABLE [dbo].[Clients]
	WITH CHECK
	ADD CONSTRAINT [FK__Clients__CN_KeyS__097F5470]
	FOREIGN KEY ([CN_KeySecondary]) REFERENCES [dbo].[Contacts] ([CN_Key])
ALTER TABLE [dbo].[Clients]
	CHECK CONSTRAINT [FK__Clients__CN_KeyS__097F5470]

GO
ALTER TABLE [dbo].[Clients]
	WITH CHECK
	ADD CONSTRAINT [FK__Clients__CU_Code__0A7378A9]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Clients]
	CHECK CONSTRAINT [FK__Clients__CU_Code__0A7378A9]

GO
CREATE NONCLUSTERED INDEX [CL_DescIndex]
	ON [dbo].[Clients] ([CL_Desc])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CL_GroupIndex]
	ON [dbo].[Clients] ([CG_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clients] SET (LOCK_ESCALATION = TABLE)
GO
