SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contacts] (
		[CN_Key]                 [int] NOT NULL,
		[CL_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_FullName]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Title]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Surname]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_FirstName]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_MiddleName]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Phone]               [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Fax]                 [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Mobile]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Email]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Addr1]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Addr2]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Addr3]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Addr4]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Addr5]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Addr6]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Position]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Dept]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Active]                 [smallint] NULL,
		[CN_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_EditOn]              [float] NULL,
		[CN_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_LastEditDate]        [float] NULL,
		[CN_LastEdit]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Contacts__B138ECAC42ACE4D4]
		PRIMARY KEY
		CLUSTERED
		([CN_Key])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [CN_ClientIndex]
	ON [dbo].[Contacts] ([CL_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CN_FullNameIndex]
	ON [dbo].[Contacts] ([CN_FullName])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contacts] SET (LOCK_ESCALATION = TABLE)
GO
