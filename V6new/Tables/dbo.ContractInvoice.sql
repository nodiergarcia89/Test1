SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContractInvoice] (
		[CI_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[CI_Number]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CI_Date]             [float] NOT NULL,
		[RE_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CT_Number]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CI_FromDate]         [float] NOT NULL,
		[CI_ToDate]           [float] NOT NULL,
		[CI_Hours]            [float] NOT NULL,
		[CI_Value]            [float] NOT NULL,
		[CI_Accepted]         [smallint] NOT NULL,
		[CI_Notes]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CI_LastEditDate]     [float] NULL,
		[CI_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Contract__2ACBCC0659904A2C]
		PRIMARY KEY
		CLUSTERED
		([CI_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ContractInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__ContractI__CC_Co__18C19800]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[ContractInvoice]
	CHECK CONSTRAINT [FK__ContractI__CC_Co__18C19800]

GO
ALTER TABLE [dbo].[ContractInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__ContractI__CL_Co__19B5BC39]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[ContractInvoice]
	CHECK CONSTRAINT [FK__ContractI__CL_Co__19B5BC39]

GO
ALTER TABLE [dbo].[ContractInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__ContractI__CT_Nu__1AA9E072]
	FOREIGN KEY ([CT_Number]) REFERENCES [dbo].[Contract] ([CT_Number])
ALTER TABLE [dbo].[ContractInvoice]
	CHECK CONSTRAINT [FK__ContractI__CT_Nu__1AA9E072]

GO
ALTER TABLE [dbo].[ContractInvoice]
	WITH CHECK
	ADD CONSTRAINT [FK__ContractI__RE_Co__1B9E04AB]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ContractInvoice]
	CHECK CONSTRAINT [FK__ContractI__RE_Co__1B9E04AB]

GO
ALTER TABLE [dbo].[ContractInvoice] SET (LOCK_ESCALATION = TABLE)
GO
