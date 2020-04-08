SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ABSCurrency] (
		[CU_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CU_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Symbol]           [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[System_Currency]     [smallint] NULL,
		[Active]              [smallint] NOT NULL,
		[CU_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__ABSCurre__0413815E00551192]
		PRIMARY KEY
		CLUSTERED
		([CU_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ABSCurrency] SET (LOCK_ESCALATION = TABLE)
GO
