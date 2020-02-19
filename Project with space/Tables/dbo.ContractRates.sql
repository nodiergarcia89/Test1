SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContractRates] (
		[CR_Key]                [int] IDENTITY(1, 1) NOT NULL,
		[CT_Number]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CR_AgencyRate]         [float] NOT NULL,
		[CR_ContractorRate]     [float] NOT NULL,
		[CR_Desc]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CR_Active]             [smallint] NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CR_LastEditDate]       [float] NULL,
		[CR_LastEdit]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Contract__CBDB691F5D60DB10]
		PRIMARY KEY
		CLUSTERED
		([CR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ContractRates]
	WITH CHECK
	ADD CONSTRAINT [FK__ContractR__CT_Nu__1C9228E4]
	FOREIGN KEY ([CT_Number]) REFERENCES [dbo].[Contract] ([CT_Number])
ALTER TABLE [dbo].[ContractRates]
	CHECK CONSTRAINT [FK__ContractR__CT_Nu__1C9228E4]

GO
ALTER TABLE [dbo].[ContractRates] SET (LOCK_ESCALATION = TABLE)
GO
