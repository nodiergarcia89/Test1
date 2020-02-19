SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Res] (
		[RE_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Desc]                                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_CodeStandard]                              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_CodeStandard]                              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CO_CodeOvertime]                              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_CodeOvertime]                              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TY_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_PrimaryRole]                               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LH_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_AutoApproveSkill]                          [smallint] NULL,
		[RE_DefaultCurrency]                           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_PaymentCurrency]                           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_DefaultTsRole]                             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_JoinDate]                                  [float] NULL,
		[RE_LeaveDate]                                 [float] NULL,
		[RE_GridBy]                                    [smallint] NULL,
		[RE_AllAct]                                    [smallint] NULL,
		[RE_AllPrj]                                    [smallint] NULL,
		[RE_AllCst]                                    [smallint] NULL,
		[RE_AllChg]                                    [smallint] NULL,
		[RE_AllType]                                   [smallint] NULL,
		[RE_AllSecurityGroups]                         [smallint] NULL,
		[RE_AutoApproveTimesheets]                     [smallint] NULL,
		[RE_EditApprovedTimesheets]                    [smallint] NULL,
		[RE_AutoApproveExpenses]                       [smallint] NULL,
		[RE_EditApprovedExpenses]                      [smallint] NULL,
		[RE_Contractor]                                [smallint] NULL,
		[RE_AvailableForScheduling]                    [smallint] NULL,
		[RE_DayLength]                                 [float] NULL,
		[RE_Virtual]                                   [smallint] NULL,
		[RE_Telephone]                                 [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Email]                                     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Info]                                      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Notes]                                     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Status1]                                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Status2]                                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Status3]                                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_AllActionType]                             [smallint] NULL,
		[RE_RestrictHoursPerDay]                       [smallint] NULL,
		[RE_MaximumHoursPerDay]                        [float] NULL,
		[RE_PlanningCost]                              [float] NULL,
		[RE_JoinAvailability]                          [float] NULL,
		[RE_LeaveAvailability]                         [float] NULL,
		[RE_PlanRateAdjust]                            [smallint] NULL,
		[Active]                                       [smallint] NULL,
		[CLC_Code]                                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_EditBy]                                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_EditOn]                                    [float] NULL,
		[RE_EditOverwriteBy]                           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_LastEdit]                                  [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_LineManager]                               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_IsTemplate]                                [smallint] NULL,
		[RE_Prefix]                                    [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_AutoNum]                                   [int] NULL,
		[US_Code]                                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_LastEditDate]                              [float] NULL,
		[RE_MaximumHoursPerDayAppliesTo]               [smallint] NULL,
		[RE_ProductiveCapacityPercentage]              [float] NULL,
		[RE_ChargeableUtilisationTargetPercentage]     [int] NULL,
		CONSTRAINT [PK__Res__096F082817AD7836]
		PRIMARY KEY
		CLUSTERED
		([RE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__RE_DefaultT__007FFA1B]
	FOREIGN KEY ([RE_DefaultTsRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__RE_DefaultT__007FFA1B]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__RE_LineMana__01741E54]
	FOREIGN KEY ([RE_LineManager]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__RE_LineMana__01741E54]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__RE_PaymentC__0268428D]
	FOREIGN KEY ([RE_PaymentCurrency]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__RE_PaymentC__0268428D]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__RE_PrimaryR__035C66C6]
	FOREIGN KEY ([RE_PrimaryRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__RE_PrimaryR__035C66C6]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__TY_Code__04508AFF]
	FOREIGN KEY ([TY_Code]) REFERENCES [dbo].[Type] ([TY_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__TY_Code__04508AFF]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__AC_Code__741A2336]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__AC_Code__741A2336]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CC_Code__750E476F]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CC_Code__750E476F]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CH_CodeOver__76026BA8]
	FOREIGN KEY ([CH_CodeOvertime]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CH_CodeOver__76026BA8]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CH_CodeStan__76F68FE1]
	FOREIGN KEY ([CH_CodeStandard]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CH_CodeStan__76F68FE1]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CL_Code__77EAB41A]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CL_Code__77EAB41A]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CLC_Code__78DED853]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CLC_Code__78DED853]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CO_CodeOver__79D2FC8C]
	FOREIGN KEY ([CO_CodeOvertime]) REFERENCES [dbo].[Cost] ([CO_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CO_CodeOver__79D2FC8C]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__CO_CodeStan__7AC720C5]
	FOREIGN KEY ([CO_CodeStandard]) REFERENCES [dbo].[Cost] ([CO_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__CO_CodeStan__7AC720C5]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__DE_Code__7BBB44FE]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__DE_Code__7BBB44FE]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__LH_Code__7CAF6937]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__LH_Code__7CAF6937]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__LO_Code__7DA38D70]
	FOREIGN KEY ([LO_Code]) REFERENCES [dbo].[Location] ([LO_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__LO_Code__7DA38D70]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__PR_Code__7E97B1A9]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__PR_Code__7E97B1A9]

GO
ALTER TABLE [dbo].[Res]
	WITH CHECK
	ADD CONSTRAINT [FK__Res__RE_DefaultC__7F8BD5E2]
	FOREIGN KEY ([RE_DefaultCurrency]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Res]
	CHECK CONSTRAINT [FK__Res__RE_DefaultC__7F8BD5E2]

GO
CREATE NONCLUSTERED INDEX [IDX_RE_DescIndex]
	ON [dbo].[Res] ([RE_Desc])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Res] SET (LOCK_ESCALATION = TABLE)
GO
