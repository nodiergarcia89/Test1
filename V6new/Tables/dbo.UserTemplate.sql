SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserTemplate] (
		[UT_Code]                                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UT_Desc]                                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UT_CostAccess]                            [smallint] NULL,
		[UT_ChargeAccess]                          [smallint] NULL,
		[UT_PlanningCostAccess]                    [smallint] NULL,
		[UT_PlanningChargeAccess]                  [smallint] NULL,
		[UT_ChargeableTsAccess]                    [smallint] NULL,
		[UT_ChargeableExpAccess]                   [smallint] NULL,
		[UT_Setup]                                 [bigint] NULL,
		[UT_InvoiceAccess]                         [smallint] NULL,
		[UT_CurrencyAccess]                        [smallint] NULL,
		[UT_DepartmentTsAccess]                    [smallint] NULL,
		[UT_DepartmentExpAccess]                   [smallint] NULL,
		[UT_UseDefaultTsDepartment]                [smallint] NULL,
		[UT_UseDefaultExpDepartment]               [smallint] NULL,
		[UT_DepartmentAssgnAccess]                 [smallint] NULL,
		[UT_ExpenseVATNet]                         [smallint] NULL,
		[UT_ClaimedExpAccess]                      [smallint] NULL,
		[UT_ExpenseClaims]                         [smallint] NULL,
		[UT_ScreenLabelAccess]                     [smallint] NULL,
		[UT_Overtime]                              [smallint] NULL,
		[UT_ApprovedTimesheet]                     [smallint] NULL,
		[UT_ApprovedExpense]                       [smallint] NULL,
		[UT_InvoicedTimesheet]                     [smallint] NULL,
		[UT_InvoicedExpense]                       [smallint] NULL,
		[UT_TimesheetNotes]                        [smallint] NULL,
		[UT_ExpenseNotes]                          [smallint] NULL,
		[UT_TimesheetApprove]                      [smallint] NULL,
		[UT_TimesheetMaintain]                     [smallint] NULL,
		[UT_TimesheetView]                         [smallint] NULL,
		[UT_ExpenseApprove]                        [smallint] NULL,
		[UT_ExpenseMaintain]                       [smallint] NULL,
		[UT_ExpenseView]                           [smallint] NULL,
		[UT_ExpCategoryAccess]                     [smallint] NULL,
		[UT_UseDefaultExpCategory]                 [smallint] NULL,
		[UT_BudgetMaintain]                        [smallint] NULL,
		[UT_BudgetView]                            [smallint] NULL,
		[UT_OptionsOwnRestrictions]                [smallint] NULL,
		[UT_OptionsSystemDefaults]                 [smallint] NULL,
		[UT_ClientGroupAccess]                     [int] NULL,
		[UT_ClosePeriods]                          [smallint] NULL,
		[UT_EditLockedMonths]                      [smallint] NULL,
		[UT_EditResEffort]                         [smallint] NULL,
		[UT_EditResDemandSupply]                   [smallint] NULL,
		[UT_AllowOtherProjects]                    [smallint] NULL,
		[UT_AllowOtherResources]                   [smallint] NULL,
		[UT_SystemFilters]                         [smallint] NULL,
		[UT_UserFilters]                           [smallint] NULL,
		[UT_CustomFields]                          [smallint] NULL,
		[UT_ViewControlledNotes]                   [smallint] NULL,
		[UT_EditControlledNotes]                   [smallint] NULL,
		[UT_Accounts]                              [smallint] NULL,
		[UT_CustomReports]                         [smallint] NULL,
		[UT_TimesheetEntryMode]                    [smallint] NULL,
		[UT_CodeConverter]                         [smallint] NULL,
		[UT_OverrideTimeEntryFormat]               [smallint] NULL,
		[UT_EditMilestoneTemplates]                [smallint] NULL,
		[UT_ImportMilestoneTemplates]              [smallint] NULL,
		[UT_DeleteMandatoryMilestones]             [smallint] NULL,
		[UT_ShareWhatIfModels]                     [smallint] NULL,
		[UT_CreateEmptyProfile]                    [int] NULL,
		[UT_DeleteConfirmedMilestones]             [smallint] NULL,
		[UT_AdjustDemand]                          [smallint] NULL,
		[UT_EditProfiles]                          [smallint] NULL,
		[UT_EditProfileExpenditure]                [smallint] NULL,
		[UT_EditMilestones]                        [smallint] NULL,
		[UT_ResProfiles]                           [smallint] NULL,
		[UT_ShowCVEffortCost]                      [smallint] NULL,
		[UT_SetPriority]                           [smallint] NULL,
		[UT_AllowAvailableToAll]                   [smallint] NULL,
		[UT_AllowDeleteLocks]                      [smallint] NULL,
		[UT_LockUsePermissions]                    [smallint] NULL,
		[UT_RoleTsAccess]                          [smallint] NULL,
		[UT_UseDefaultTsRole]                      [smallint] NULL,
		[UT_AllowClaimDemand]                      [smallint] NULL,
		[UT_AllowOverrideClaimedDemand]            [smallint] NULL,
		[UT_CreateLinkTemplate]                    [smallint] NULL,
		[UT_UseLinkTemplate]                       [smallint] NULL,
		[Active]                                   [smallint] NULL,
		[UT_LastEdit]                              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UT_AllowDataLoad]                         [smallint] NULL,
		[UT_CostCentreTsAccess]                    [smallint] NULL,
		[UT_CostCentreExpAccess]                   [smallint] NULL,
		[UT_AllowEditReadonlyActions]              [smallint] NULL,
		[UT_BillingInvoiceAccess]                  [smallint] NULL,
		[UT_BillingContractAccess]                 [smallint] NULL,
		[UT_AllowTAndEApprvCL]                     [smallint] NULL,
		[UT_AbilityToChangeTimesheetEntryView]     [smallint] NULL,
		[UT_PaidExpChargeAccess]                   [smallint] NULL,
		[UT_ControlledCFAccess]                    [smallint] NULL,
		[UT_ViewPrivateProfiles]                   [smallint] NULL,
		[UT_AllowPrivateProfiles]                  [smallint] NULL,
		[UT_ScenarioAccess]                        [smallint] NULL,
		[UT_CanBaselineScenarios]                  [smallint] NULL,
		[UT_CanApproveScenarios]                   [smallint] NULL,
		[US_Code]                                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UT_LastEditDate]                          [float] NULL,
		[UT_CanMaintainTimesheetSubmissions]       [smallint] NULL,
		[UT_AbilityToCreatePosts]                  [smallint] NULL,
		[UT_RestoreCompleteMilestones]             [smallint] NULL,
		[UT_UnfinishProcess]                       [smallint] NULL,
		[UT_MilestonePublishLevel]                 [int] NULL,
		[UT_TimesheetNotesRequired]                [smallint] NULL,
		[UT_CanEditSubmittedTimesheets]            [smallint] NULL,
		[UT_BenefitsAccess]                        [smallint] NULL,
		[UT_BenefitActualsMaintain]                [smallint] NULL,
		[UT_SetupBillingPriceLists]                [smallint] NULL,
		[UT_BaselineDeliverables]                  [smallint] NULL,
		[UT_AllowInvoiceDeAuthorise]               [smallint] NULL,
		[UT_ShowActivity]                          [smallint] NOT NULL,
		[AC_Code]                                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UT_ShowTask]                              [smallint] NOT NULL,
		[CF_Key_DirectEntry1]                      [int] NULL,
		[CF_Key_DirectEntry2]                      [int] NULL,
		[UT_CustomViewAccess]                      [smallint] NOT NULL,
		[UT_DashboardAccess]                       [smallint] NOT NULL,
		[UT_ShowCVEffortCharge]                    [smallint] NULL,
		[UT_AbilityToAutoGenerateSupply]           [smallint] NULL,
		[UT_CanEnterNegativeTimesheetHours]        [smallint] NULL,
		[UT_AllowAssignWidgetAddTime]              [smallint] NULL,
		[UT_MilestonePublishLevelDefault]          [int] NULL,
		[UT_PortfolioKanban]                       [smallint] NULL,
		[UT_AbilityToTakeProjectSnapshots]         [smallint] NULL,
		[UT_PlanningMaintainProtectedTasks]        [smallint] NOT NULL,
		[UT_PlanningViewActualEffort]              [smallint] NULL,
		CONSTRAINT [PK__UserTemp__B9DE860203FB8544]
		PRIMARY KEY
		CLUSTERED
		([UT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Sh__05E3CDB6]
	DEFAULT ((-1)) FOR [UT_ShowActivity]
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Sh__06D7F1EF]
	DEFAULT ((0)) FOR [UT_ShowTask]
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Cu__07CC1628]
	DEFAULT ((0)) FOR [UT_CustomViewAccess]
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Da__08C03A61]
	DEFAULT ((0)) FOR [UT_DashboardAccess]
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Al__5ED4ED8D]
	DEFAULT ((-1)) FOR [UT_AllowAssignWidgetAddTime]
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Mi__61B15A38]
	DEFAULT ((1)) FOR [UT_MilestonePublishLevelDefault]
GO
ALTER TABLE [dbo].[UserTemplate]
	ADD
	CONSTRAINT [DF__UserTempl__UT_Pl__62707447]
	DEFAULT ((0)) FOR [UT_PlanningMaintainProtectedTasks]
GO
ALTER TABLE [dbo].[UserTemplate]
	WITH CHECK
	ADD CONSTRAINT [FK__UserTempl__AC_Co__1ECF7711]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[UserTemplate]
	CHECK CONSTRAINT [FK__UserTempl__AC_Co__1ECF7711]

GO
ALTER TABLE [dbo].[UserTemplate] SET (LOCK_ESCALATION = TABLE)
GO
