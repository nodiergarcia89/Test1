SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Type] (
		[TY_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TY_Desc]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Active]                     [smallint] NULL,
		[TY_LastEdit]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_UseUnits]                [smallint] NULL,
		[TY_UnitCost]                [float] NULL,
		[TY_Net]                     [smallint] NULL,
		[TY_UnitLabel]               [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_UnitsLabel]              [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_VAT]                     [float] NULL,
		[TY_ChargeUp]                [float] NULL,
		[NC_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_AllRes]                  [smallint] NULL,
		[TY_AllPrj]                  [smallint] NULL,
		[TY_Status1]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_Status2]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_Status3]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_LastEditDate]            [float] NULL,
		[TY_AllowReceipt]            [smallint] NULL,
		[TY_ReimbursableDefault]     [smallint] NULL,
		CONSTRAINT [PK__Type__C58C74D55911273F]
		PRIMARY KEY
		CLUSTERED
		([TY_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Type]
	WITH CHECK
	ADD CONSTRAINT [FK__Type__CU_Code__0CB0C6D6]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Type]
	CHECK CONSTRAINT [FK__Type__CU_Code__0CB0C6D6]

GO
ALTER TABLE [dbo].[Type]
	WITH CHECK
	ADD CONSTRAINT [FK__Type__EC_Code__0DA4EB0F]
	FOREIGN KEY ([EC_Code]) REFERENCES [dbo].[ExpCategory] ([EC_Code])
ALTER TABLE [dbo].[Type]
	CHECK CONSTRAINT [FK__Type__EC_Code__0DA4EB0F]

GO
ALTER TABLE [dbo].[Type]
	WITH CHECK
	ADD CONSTRAINT [FK__Type__NC_Code__0E990F48]
	FOREIGN KEY ([NC_Code]) REFERENCES [dbo].[Nominal] ([NC_Code])
ALTER TABLE [dbo].[Type]
	CHECK CONSTRAINT [FK__Type__NC_Code__0E990F48]

GO
ALTER TABLE [dbo].[Type] SET (LOCK_ESCALATION = TABLE)
GO
