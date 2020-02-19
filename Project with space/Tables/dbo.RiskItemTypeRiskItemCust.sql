SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskItemTypeRiskItemCust] (
		[RIT_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CF_Key]        [int] NOT NULL,
		[RTR_Order]     [int] NULL,
		CONSTRAINT [PK__RiskItem__D5C40FD22A8B4280]
		PRIMARY KEY
		CLUSTERED
		([RIT_Code], [CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RiskItemTypeRiskItemCust]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItemT__CF_Ke__443605EA]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[RiskItemTypeRiskItemCust]
	CHECK CONSTRAINT [FK__RiskItemT__CF_Ke__443605EA]

GO
ALTER TABLE [dbo].[RiskItemTypeRiskItemCust]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskItemT__RIT_C__452A2A23]
	FOREIGN KEY ([RIT_Code]) REFERENCES [dbo].[RiskItemType] ([RIT_Code])
ALTER TABLE [dbo].[RiskItemTypeRiskItemCust]
	CHECK CONSTRAINT [FK__RiskItemT__RIT_C__452A2A23]

GO
ALTER TABLE [dbo].[RiskItemTypeRiskItemCust] SET (LOCK_ESCALATION = TABLE)
GO
