SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExchangeRate] (
		[CU_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ER_StartDate]        [float] NOT NULL,
		[ER_Rate]             [float] NOT NULL,
		[ER_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ER_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Exchange__B22B5280035179CE]
		PRIMARY KEY
		CLUSTERED
		([CU_Code], [ER_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ExchangeRate]
	WITH CHECK
	ADD CONSTRAINT [FK__ExchangeR__CU_Co__55CAA640]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[ExchangeRate]
	CHECK CONSTRAINT [FK__ExchangeR__CU_Co__55CAA640]

GO
ALTER TABLE [dbo].[ExchangeRate] SET (LOCK_ESCALATION = TABLE)
GO
