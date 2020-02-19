SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users] (
		[US_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Desc]                          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Password]                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UT_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_ProductTimesheet]              [smallint] NULL,
		[US_ProductWeb]                    [smallint] NULL,
		[US_ProductForecast]               [smallint] NULL,
		[US_TimesheetApprove]              [smallint] NULL,
		[US_TimesheetMaintain]             [smallint] NULL,
		[US_TimesheetView]                 [smallint] NULL,
		[US_ExpenseApprove]                [smallint] NULL,
		[US_ExpenseMaintain]               [smallint] NULL,
		[US_ExpenseView]                   [smallint] NULL,
		[US_ExpensePay]                    [smallint] NULL,
		[US_BudgetMaintain]                [smallint] NULL,
		[US_BudgetView]                    [smallint] NULL,
		[US_RiskView]                      [smallint] NULL,
		[US_RiskMaintain]                  [smallint] NULL,
		[US_RiskAllowAdd]                  [smallint] NULL,
		[US_RiskAllowDelete]               [smallint] NULL,
		[US_ScheduleViewPrj]               [smallint] NULL,
		[US_ScheduleViewRes]               [smallint] NULL,
		[US_ScheduleMainPrj]               [smallint] NULL,
		[US_ScheduleMainRes]               [smallint] NULL,
		[US_SetupViewPrj]                  [smallint] NULL,
		[US_SetupViewRes]                  [smallint] NULL,
		[US_SetupMainPrj]                  [smallint] NULL,
		[US_SetupMainRes]                  [smallint] NULL,
		[US_SetupViewCli]                  [smallint] NULL,
		[US_SetupMainCli]                  [smallint] NULL,
		[US_SetupCliAllowAdd]              [smallint] NULL,
		[US_SetupCliAllowDelete]           [smallint] NULL,
		[US_SetupCliAllSecurityGroups]     [smallint] NULL,
		[US_ActionView]                    [smallint] NULL,
		[US_ActionMaintain]                [smallint] NULL,
		[US_ActionAllowAdd]                [smallint] NULL,
		[US_ActionAllowDelete]             [smallint] NULL,
		[US_Status1]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Status2]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Status3]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_TimeEntryUnits]                [smallint] NULL,
		[US_ReportDisplayUnits]            [smallint] NULL,
		[US_ScheduleFilter]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_ScheduleTBState]               [smallint] NULL,
		[US_ScheduleMovePeriod]            [smallint] NULL,
		[US_ScheduleZoom]                  [smallint] NULL,
		[US_EntryInfoPanelSize]            [int] NULL,
		[US_ShowNonVisibleTime]            [smallint] NULL,
		[US_TrustedDTLogon]                [smallint] NULL,
		[US_TrustedWebLogon]               [smallint] NULL,
		[US_TrustedDTCheckDomain]          [smallint] NULL,
		[US_TrustedWebCheckDomain]         [smallint] NULL,
		[US_TrustedDomain]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_TrustedUserID]                 [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_PasswordChanged]               [float] NULL,
		[US_PasswordForceChange]           [smallint] NULL,
		[US_PasswordNoExpiry]              [smallint] NULL,
		[LG_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_ContractorView]                [smallint] NULL,
		[US_ContractsAllowAdd]             [smallint] NULL,
		[US_ContractsAllowAmend]           [smallint] NULL,
		[US_ContractsAllowDelete]          [smallint] NULL,
		[US_InvoicesAllowAdd]              [smallint] NULL,
		[US_InvoicesAllowAmend]            [smallint] NULL,
		[US_InvoicesAllowDelete]           [smallint] NULL,
		[US_SkillPropose]                  [smallint] NULL,
		[US_SkillApprove]                  [smallint] NULL,
		[US_BudgetProjectPlanViewPrj]      [smallint] NULL,
		[US_BudgetProjectPlanMainPrj]      [smallint] NULL,
		[US_BudPlanAllowApprDelete]        [smallint] NULL,
		[US_ProjPlanAllowApprDelete]       [smallint] NULL,
		[US_BaselineAllowCreate]           [smallint] NULL,
		[US_BaselineAllowDelete]           [smallint] NULL,
		[US_AllowRecalcActuals]            [smallint] NULL,
		[US_DirectProfile]                 [smallint] NULL,
		[US_StartPage]                     [int] NULL,
		[Active]                           [smallint] NULL,
		[US_LastEdit]                      [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_UserID]                        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLC_Code]                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_SystemRoles]                   [int] NULL,
		[US_DeliverableView]               [smallint] NULL,
		[US_DeliverableMaintain]           [smallint] NULL,
		[US_SupplyView]                    [smallint] NULL,
		[US_DepProfileView]                [smallint] NULL,
		[US_DepProfileMaintain]            [smallint] NULL,
		[US_DepAllowViewPeople]            [smallint] NULL,
		[US_ResDeploymentView]             [smallint] NULL,
		[US_ResDeploymentMaintain]         [smallint] NULL,
		[US_BillingProjects]               [smallint] NULL,
		[US_PublishCalPublic]              [smallint] NULL,
		[US_PublishCalPrivate]             [smallint] NULL,
		[US_PublishCalPrivateCheck]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_IsTemplate]                    [smallint] NULL,
		[US_SecurityMode]                  [smallint] NULL,
		[US_CodeLastEdit]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_LastEditDate]                  [float] NULL,
		[CLC_CodeFormat]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_RememberMe]                    [smallint] NULL,
		[US_ActionViewResPrj]              [smallint] NULL,
		[US_ActionMaintainResPrj]          [smallint] NULL,
		[US_FederationID]                  [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_ExemptFromEnforcedSSO]         [smallint] NULL,
		[US_BypassWhitelisting]            [smallint] NULL,
		[US_IsExternal]                    [smallint] NULL,
		CONSTRAINT [PK__Users__606A09607C5A637C]
		PRIMARY KEY
		CLUSTERED
		([US_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Users]
	WITH CHECK
	ADD CONSTRAINT [FK__Users__CLC_Code__19169DBB]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[Users]
	CHECK CONSTRAINT [FK__Users__CLC_Code__19169DBB]

GO
ALTER TABLE [dbo].[Users]
	WITH CHECK
	ADD CONSTRAINT [FK__Users__CLC_CodeF__1A0AC1F4]
	FOREIGN KEY ([CLC_CodeFormat]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[Users]
	CHECK CONSTRAINT [FK__Users__CLC_CodeF__1A0AC1F4]

GO
ALTER TABLE [dbo].[Users]
	WITH CHECK
	ADD CONSTRAINT [FK__Users__LG_Code__1AFEE62D]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[Users]
	CHECK CONSTRAINT [FK__Users__LG_Code__1AFEE62D]

GO
ALTER TABLE [dbo].[Users]
	WITH CHECK
	ADD CONSTRAINT [FK__Users__RE_Code__1BF30A66]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Users]
	CHECK CONSTRAINT [FK__Users__RE_Code__1BF30A66]

GO
ALTER TABLE [dbo].[Users]
	WITH CHECK
	ADD CONSTRAINT [FK__Users__UT_Code__1CE72E9F]
	FOREIGN KEY ([UT_Code]) REFERENCES [dbo].[UserTemplate] ([UT_Code])
ALTER TABLE [dbo].[Users]
	CHECK CONSTRAINT [FK__Users__UT_Code__1CE72E9F]

GO
CREATE NONCLUSTERED INDEX [US_TrustedUserIDIndex]
	ON [dbo].[Users] ([US_TrustedUserID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [US_UserIDIndex]
	ON [dbo].[Users] ([US_UserID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] SET (LOCK_ESCALATION = TABLE)
GO
